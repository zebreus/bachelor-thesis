use std::{
    io::{self},
    path::PathBuf,
};

mod copy_crate;
mod modify_sources;

use copy_crate::copy_crate;

use modify_sources::modify_sources;

use thiserror::Error;

#[derive(Error, Debug)]
pub enum ExtractCrateError {
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error(transparent)]
    FsExtraError(#[from] fs_extra::error::Error),
    #[error("The source crate directory does not exist")]
    SourceCrateDoesNotExist,
    #[error("The source crate does not contain a Cargo.toml file")]
    NoCargoToml,
    #[error("The specified function file {function_file} does not exist")]
    FunctionFileDoesNotExist { function_file: PathBuf },
    #[error("There is already a crate at the target location")]
    TargetCrateAlreadyExists,
}

pub struct ExtractOptions {
    pub original_crate_path: PathBuf,
    pub target_crate_path: PathBuf,
    pub function_name: String,
    /// The file containing the function to be synthesized.
    /// Path is relative to the crate's src directory.
    pub function_file: PathBuf,
}

/// Returns the path to the extracted crate if successful.
pub fn extract_function_crate(options: &ExtractOptions) -> Result<(), ExtractCrateError> {
    let ExtractOptions {
        original_crate_path,
        target_crate_path,
        function_name,
        function_file,
    } = options;

    copy_crate(original_crate_path, target_crate_path)?;

    modify_sources(target_crate_path, function_name, function_file)?;

    return Ok(());
}

#[cfg(test)]
mod tests {
    use std::process::Command;

    use tempfile::TempDir;

    use super::*;

    #[test]
    fn extract_function_declared_in_module_registered_but_not_exported_in_lib() {
        let dir = TempDir::new().unwrap();

        let target_crate_path = dir.path().join("extract_function_test").to_path_buf();
        let original_crate_path = PathBuf::from("test_suites/extract_function_test")
            .to_path_buf()
            .canonicalize()
            .unwrap();
        let function_name = "subtract";
        let function_file = "subtract.rs";

        let options = ExtractOptions {
            original_crate_path: original_crate_path,
            target_crate_path: target_crate_path.clone(),
            function_name: function_name.to_string(),
            function_file: PathBuf::from(function_file),
        };

        extract_function_crate(&options).unwrap();

        // Try building the extracted crate
        let output = Command::new("cargo")
            .arg("build")
            .current_dir(&target_crate_path)
            .output()
            .expect("Failed to run cargo build");

        let exit_code = output.status.code().unwrap();
        if exit_code != 0 {
            println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
            println!("stderr: {}", String::from_utf8_lossy(&output.stderr));
            let _keep_tempdir = dir.into_path();
            panic!(
                "Failed to build extracted crate ({})",
                target_crate_path.to_str().unwrap()
            );
        }
    }
}
