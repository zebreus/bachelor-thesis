use std::{
    fs::{self, read_to_string},
    io,
    path::PathBuf,
    process::Command,
};

use cargo_toml::Manifest;
use derive_builder::Builder;
use tempfile::TempDir;

use crate::{
    caching::CachePath,
    extract_function_crate::{extract_function_crate, ExtractCrateError, ExtractOptions},
    generate_hls_script::{generate_hls_script, GenerateHlsOptions},
};

use thiserror::Error;

#[derive(Error, Debug)]
pub enum RustHlsError {
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error(transparent)]
    ExtractCrateError(#[from] ExtractCrateError),
    #[error("Encountered an error during high level synthesis. See attached logs for details.")]
    HighLevelSynthesisFailed {
        error: String,
        out: String,
        exitcode: i32,
    },
    #[error("High level synthesis did not fail, but did not produce a result either. See attached logs for details.")]
    HighLevelSynthesisDidNotProduceResult { error: String, out: String },
    #[error("Failed to parse cargo toml in the generated crate")]
    FailedToParseCargoToml(#[from] cargo_toml::Error),
    #[error("Failed to get a valid package name from cargo toml")]
    FailedToGetPackageName,
    #[error("Verilog has not yet been generated. Run executeHlsScript first.")]
    VerilogNotYetGenerated,
    #[error(transparent)]
    CachingError(#[from] crate::caching::CachingError),
}

#[derive(Builder)]
#[builder(pattern = "owned")]
pub struct RustHls {
    #[builder(default = "TempDir::new().unwrap()")]
    /// Used as a temporary directory for the extracted crate
    temporary_directory: TempDir,
    #[builder(default = "None")]
    /// Used as a temporary directory for the extracted crate
    cache_path: Option<CachePath>,
    #[builder(default = "PathBuf::from(\"./.\")")]
    /// Path to the original crate
    crate_path: PathBuf,
    #[builder(default = "String::from(\"add\")")]
    /// Name of the function to synthesize
    function_name: String,
    /// File containing the function to synthesize. Relative to crate root.
    function_file: PathBuf,
    #[builder(default = "None")]
    /// Select flags that will be passed to the rust compiler.
    ///
    /// Defaults to: [super::generate_hls_script::DEFAULT_RUST_FLAGS]
    rust_flags: Option<String>,
    #[builder(default = "None")]
    /// Select flags that will be passed to the HLS tool (bambu).
    ///
    /// Defaults to: [super::generate_hls_script::DEFAULT_HLS_FLAGS]
    hls_flags: Option<String>,
}

impl RustHls {
    /// Extract the crate into the target directory
    pub fn extract_crate(&mut self) -> Result<&mut Self, RustHlsError> {
        let extract_options = ExtractOptions {
            original_crate_path: self.crate_path.clone(),
            target_crate_path: self.temporary_directory.path().to_path_buf(),
            function_name: self.function_name.clone(),
            function_file: self.function_file.clone(),
        };

        extract_function_crate(&extract_options)?;

        Ok(self)
    }

    pub fn prepare_hls(&mut self) -> Result<&mut Self, RustHlsError> {
        let cargo_toml_path = self
            .temporary_directory
            .path()
            .to_path_buf()
            .join("Cargo.toml");
        let cargo_toml_content = fs::read(cargo_toml_path)?;
        let manifest = Manifest::from_slice(cargo_toml_content.as_slice())?;
        let crate_name = manifest
            .package
            .and_then(|package| Some(package.name))
            .ok_or(RustHlsError::FailedToGetPackageName)?;

        let generate_hls_options = GenerateHlsOptions {
            function_name: self.function_name.clone(),
            crate_name: crate_name,
            rust_flags: self.rust_flags.clone(),
            hls_flags: self.hls_flags.clone(),
        };

        generate_hls_script(
            &self.temporary_directory.path().to_path_buf(),
            &generate_hls_options,
        )?;

        Ok(self)
    }

    pub fn execute_hls_script(&mut self) -> Result<&mut Self, RustHlsError> {
        let new_cache_path = CachePath::new(self.temporary_directory.path().to_path_buf())?;
        self.cache_path = Some(new_cache_path.clone());

        // if let CachePath::Cached { .. } = new_cache_path {
        //     self.cache_path = Some(new_cache_path);
        //     return Ok(self);
        // }

        let working_directory = match &new_cache_path {
            CachePath::Cached { .. } => {
                self.cache_path = Some(new_cache_path);
                return Ok(self);
            }
            CachePath::Uncached { working_path, .. } => working_path.clone(),
        };

        let output = Command::new("/usr/bin/env")
            .arg("bash")
            .arg("hls.sh")
            .current_dir(&working_directory)
            .output()?;

        let exit_code = output.status.code().unwrap_or(0);
        if exit_code != 0 {
            println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
            println!("stderr: {}", String::from_utf8_lossy(&output.stderr));
            return Err(RustHlsError::HighLevelSynthesisFailed {
                error: String::from_utf8_lossy(&output.stderr).to_string(),
                out: String::from_utf8_lossy(&output.stdout).to_string(),
                exitcode: exit_code,
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
        self.cache_path = Some(new_cache_path);

        Ok(self)
    }

    pub fn get_generated_verilog(&mut self) -> Result<String, RustHlsError> {
        let cache_path = match &self.cache_path {
            None => {
                let cache_path = CachePath::new(self.temporary_directory.path().to_path_buf())?;
                self.cache_path = Some(cache_path);
                self.cache_path.as_ref().unwrap()
            }
            Some(cache_path) => cache_path,
        };

        let target_crate_path = match cache_path {
            CachePath::Cached { path } => Ok(path),
            CachePath::Uncached { .. } => Err(RustHlsError::VerilogNotYetGenerated),
        }?;

        let result_path = target_crate_path.join("result.v");
        let result = read_to_string(result_path);
        Ok(result?)
    }

    pub fn do_everything(&mut self) -> Result<String, RustHlsError> {
        let result = self
            .extract_crate()?
            .prepare_hls()?
            .execute_hls_script()?
            .get_generated_verilog()?;
        Ok(result)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn synthesizing_test_crate_creates_verilog_file() {
        let mut options = RustHlsBuilder::create_empty()
            .crate_path(PathBuf::from("test_suites/test_crate"))
            .function_name("add".into())
            .function_file(PathBuf::from("add.rs"))
            .build()
            .unwrap();

        let generated_verilg = options.do_everything().unwrap();

        assert!(generated_verilg.lines().count() > 100);
    }
}