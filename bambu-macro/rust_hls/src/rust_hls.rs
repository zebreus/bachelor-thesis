use std::{
    collections::HashMap,
    env,
    fs::{self, read_to_string, write, File},
    io::{self, Write},
    path::PathBuf,
    process::Command,
    thread::sleep,
    time::Duration,
};

use cargo_toml::Manifest;
use rand::{distributions::Alphanumeric, thread_rng, Rng};
use serde::Serialize;

use crate::{
    cache_workspace::{add_to_workspace, WorkspaceLock},
    caching::CachePath,
};

use thiserror::Error;

#[derive(Error, Debug)]
pub enum RustHlsError {
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error(
        "Encountered an error during high level synthesis. See attached logs at {path} <{path}> ."
    )]
    HighLevelSynthesisFailed { exitcode: i32, path: String },
    #[error("High level synthesis did not fail, but did not produce a result either. See attached logs for details.")]
    HighLevelSynthesisDidNotProduceResult { error: String, out: String },
    #[error("Failed to parse cargo toml in the generated crate")]
    FailedToParseCargoToml(#[from] cargo_toml::Error),
    #[error("Failed to get a valid package name from cargo toml")]
    FailedToGetPackageName,
    #[error("Verilog has not yet been generated. Run executeHlsScript first.")]
    VerilogNotYetGenerated,
    #[error("Caching error:")]
    CachingError(#[from] crate::caching::CachingError),
    #[error("Failed to generate cargo toml for the generated crate")]
    FailedToGenerateCargoToml(#[from] toml::ser::Error),
    #[error("Failed to access workspace package")]
    FailedToAccessWorkspacePackage,
}

#[derive(Debug, Clone, Serialize, Hash)]
pub struct CrateFile {
    /// The path of the file relative to the crate root
    pub path: PathBuf,
    /// The content of the file
    pub content: String,
}

impl CrateFile {
    pub fn new(path: PathBuf, content: String) -> Self {
        Self { path, content }
    }
    pub fn from_file(path: PathBuf) -> Result<Self, io::Error> {
        Ok(Self {
            path: path.clone(),
            content: read_to_string(path)?,
        })
    }
    pub fn write(&self) -> Result<(), io::Error> {
        let parent = self.path.parent().ok_or(std::io::Error::new(
            std::io::ErrorKind::Other,
            "Failed to get parent directory",
        ))?;
        fs::create_dir_all(parent)?;
        write(&self.path, &self.content)
    }
}

/// The HLS process is instrumented and controlled by this struct.
///
/// You can create a new instance of this struct using the `new` function.
///
/// The `execute` function will write the files to disk, execute the HLS process and return the resulting Verilog.
pub struct RustHls {
    /// List of all files in the temporary crate
    files: Vec<CrateFile>,
}

pub struct RustHlsResult {
    /// Content of the verilog file
    pub verilog: String,
    /// Relevant generated files
    pub files: Vec<CrateFile>,
}

impl RustHls {
    /// Creates a new instance of RustHls.
    ///
    /// The new instance will synthesize from a temporary crate containing the given files.
    ///
    /// A hls.sh script will be generated and added to the crate.
    pub fn new(files: Vec<CrateFile>) -> Self {
        Self { files }
    }

    /// Writes the files to disk, execute the HLS process and return the resulting Verilog.
    ///
    /// The results are cached, so if you call this function again with the same files, it will return the cached result.
    pub fn execute(&self) -> Result<RustHlsResult, RustHlsError> {
        let new_cache_path = CachePath::from_files(&self.files)?;

        if let CachePath::Cached { .. } = new_cache_path {
            return self.get_result(&new_cache_path);
        }

        let workspace_lock = WorkspaceLock::new()?;

        let new_cache_path = new_cache_path.update()?;

        let working_directory = match &new_cache_path {
            CachePath::Cached { .. } => {
                return self.get_result(&new_cache_path);
            }
            CachePath::Uncached { working_path, .. } => working_path.clone(),
        };

        // Add this package to the workspace
        add_to_workspace(&working_directory.clone())?;

        // Generate new random package name to avoid conflicts
        let cargo_toml_content = fs::read(working_directory.join("Cargo.toml"))?;
        let mut manifest = Manifest::from_slice(cargo_toml_content.as_slice())?;
        let Some(package) = manifest.package.as_mut() else  {
            return Err(RustHlsError::FailedToGetPackageName);
        };
        let mut new_name: String = working_directory
            .canonicalize()?
            .file_name()
            .and_then(|name| name.to_str().map(|b| b.to_string()))
            .unwrap_or(
                thread_rng()
                    .sample_iter(&Alphanumeric)
                    .take(50)
                    .map(char::from)
                    .collect(),
            );
        new_name.retain(|c| c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z');
        package.name = new_name.clone();
        let mut buffer = String::new();
        let serializer = toml::Serializer::new(&mut buffer);
        manifest.serialize(serializer)?;
        File::create(working_directory.join("Cargo.toml"))?.write_all(buffer.as_bytes())?;

        eprintln!("Executing HLS script in {:?}", working_directory);
        sleep(Duration::from_millis(5000));

        // Clear all cargo environment variables, so that the script can be executed in a clean environment
        let filtered_env: HashMap<String, String> = env::vars()
            .filter(|&(ref key, _)| !key.starts_with("CARGO_"))
            .collect();

        let output = Command::new("/usr/bin/env")
            .arg("bash")
            .arg("hls.sh")
            .env_clear()
            .envs(&filtered_env)
            .current_dir(&working_directory)
            .output()?;

        let exit_code = output.status.code().unwrap_or(0);
        if exit_code != 0 {
            println!("stdout:\n{}", String::from_utf8_lossy(&output.stdout));
            println!("stderr:\n{}", String::from_utf8_lossy(&output.stderr));
            return Err(RustHlsError::HighLevelSynthesisFailed {
                // TODO: Classify errors by parsing stderr
                exitcode: exit_code,
                path: working_directory.to_string_lossy().to_string(),
            });
        }

        let result_path = working_directory.join("result.v");

        if !result_path.exists() {
            return Err(RustHlsError::HighLevelSynthesisDidNotProduceResult {
                error: String::from_utf8_lossy(&output.stderr).to_string(),
                out: String::from_utf8_lossy(&output.stdout).to_string(),
            });
        }

        let new_cache_path = new_cache_path.finalize()?;
        // TODO: Remove contents of working directory and replace them with a dummy crate
        write(working_directory.join("done.txt"), "")?;

        workspace_lock.unlock();

        self.get_result(&new_cache_path)
    }

    fn get_result(&self, cache_path: &CachePath) -> Result<RustHlsResult, RustHlsError> {
        let final_path = match cache_path {
            CachePath::Cached { path } => Ok(path),
            CachePath::Uncached { .. } => Err(RustHlsError::VerilogNotYetGenerated),
        }?;
        let verilog_path = final_path.join("result.v");
        let verilog = read_to_string(&verilog_path)?;
        let verilog_file = CrateFile {
            path: verilog_path,
            content: verilog.clone(),
        };
        return Ok(RustHlsResult {
            verilog: verilog,
            files: vec![verilog_file],
        });
    }
}

#[cfg(test)]
mod tests {
    use rust_hls_macro_lib::HlsArguments;

    use crate::generate_hls_script::{generate_hls_script, GenerateHlsOptions};

    use super::*;

    #[test]
    fn synthesizing_test_crate_creates_verilog_file() {
        let options = GenerateHlsOptions {
            function_name: "add779".into(),
            hls_arguments: HlsArguments::default(),
        };

        let files = vec![
            CrateFile {
                path: PathBuf::from("Cargo.toml"),
                content: String::from(
                    r#"
                [package]
                name = "test_crate"
                version = "0.1.0"
                
                "#,
                ),
            },
            CrateFile {
                path: PathBuf::from("src/lib.rs"),
                content: String::from(
                    r#"
                    #[no_mangle]
                    pub extern fn add779(left: usize, right: usize) -> usize {
                        left + right
                    }
                "#,
                ),
            },
            CrateFile::new("hls.sh".into(), generate_hls_script(&options)),
        ];

        let rust_hls = RustHls::new(files);

        let result = rust_hls.execute().unwrap();

        assert!(result.verilog.lines().count() > 100);
        assert!(result.verilog.contains("add779"));
    }
}
