use std::{
    fs::read_to_string,
    io::{self},
    path::{PathBuf, StripPrefixError},
};

use derive_builder::Builder;
use tempfile::TempDir;

use crate::{
    extract_function_crate::{extract_function_crate, ExtractCrateError, ExtractOptions},
    generate_hls_script::GenerateHlsOptions,
    rust_hls::CrateFile,
    RustHls, RustHlsError,
};

use thiserror::Error;

#[derive(Error, Debug)]
pub enum RustHlsOldError {
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error(transparent)]
    PatternError(#[from] glob::PatternError),
    #[error(transparent)]
    GlobError(#[from] glob::GlobError),
    #[error(transparent)]
    StripPrefixError(#[from] StripPrefixError),
    #[error(transparent)]
    ExtractCrateError(#[from] ExtractCrateError),
    #[error(
        "Encountered an error during high level synthesis. See attached logs at {path} <{path}> ."
    )]
    HighLevelSynthesisFailed {
        error: String,
        out: String,
        exitcode: i32,
        path: String,
    },
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
    #[error(transparent)]
    RustHlsError(#[from] RustHlsError),
}

#[derive(Builder)]
#[builder(pattern = "owned")]
/// Configuration data for a high-level synthesis process
/// Previous interface for performing HLS from Rust
pub struct RustHlsOld {
    #[builder(default = "TempDir::new().unwrap()")]
    /// Used as a temporary directory for the extracted crate
    temporary_directory: TempDir,
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
    #[builder(default = "None")]
    /// New rust hls instance
    new_rust_hls: Option<RustHls>,
}

impl RustHlsOld {
    /// Extract the crate into the target directory
    pub fn extract_crate(&mut self) -> Result<&mut Self, RustHlsOldError> {
        let extract_options = ExtractOptions {
            original_crate_path: self.crate_path.clone(),
            target_crate_path: self.temporary_directory.path().to_path_buf(),
            function_name: self.function_name.clone(),
            function_file: self.function_file.clone(),
        };

        let extracted_location = extract_function_crate(&extract_options)?;
        self.function_file = extracted_location.function_file;

        let extraced_files = glob::glob(
            format!(
                "{}/**/*",
                extracted_location.path.to_string_lossy().to_string()
            )
            .as_str(),
        )?
        .filter(|path| match path {
            Ok(path) => std::fs::metadata(path)
                .and_then(|metadata| Ok(metadata.is_file()))
                .unwrap_or(false),
            Err(_) => true,
        })
        .map(|path| -> Result<_, RustHlsOldError> {
            match path {
                Ok(path) => {
                    let without_prefix =
                        PathBuf::from(path.strip_prefix(&extracted_location.path)?);
                    Ok((path, without_prefix))
                }
                Err(e) => Err(e.into()),
            }
        })
        .collect::<Result<Vec<(PathBuf, PathBuf)>, _>>()?;

        let crate_files = extraced_files
            .into_iter()
            .map(
                |(absolute_path, relative_path)| -> Result<_, RustHlsOldError> {
                    Ok(CrateFile {
                        path: relative_path,
                        content: read_to_string(absolute_path)?,
                    })
                },
            )
            .collect::<Result<Vec<CrateFile>, _>>()?;

        let generate_hls_options = GenerateHlsOptions {
            function_name: self.function_name.clone(),
            rust_flags: self.rust_flags.clone(),
            hls_flags: self.hls_flags.clone(),
        };

        let rust_hls = RustHls::new(crate_files, generate_hls_options);

        self.new_rust_hls = Some(rust_hls);

        Ok(self)
    }

    pub fn execute_hls_script(&mut self) -> Result<&mut Self, RustHlsOldError> {
        match self.new_rust_hls {
            // Not the correct error but gets deleted anyway
            None => Err(RustHlsOldError::VerilogNotYetGenerated),
            Some(ref mut rust_hls) => {
                rust_hls.execute()?;
                Ok(self)
            }
        }
    }

    pub fn get_generated_verilog(&mut self) -> Result<String, RustHlsOldError> {
        let result = match self.new_rust_hls {
            // Not the correct error but gets deleted anyway
            None => return Err(RustHlsOldError::VerilogNotYetGenerated),
            Some(ref mut rust_hls) => rust_hls.execute()?,
        };
        let verilog = result.verilog;
        Ok(verilog)
    }

    pub fn do_everything(&mut self) -> Result<String, RustHlsOldError> {
        let result = self.extract_crate()?.get_generated_verilog()?;
        Ok(result)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn synthesizing_test_crate_creates_verilog_file() {
        let mut options = RustHlsOldBuilder::create_empty()
            .crate_path(PathBuf::from("test_suites/test_crate"))
            .function_name("add".into())
            .function_file(PathBuf::from("add.rs"))
            .build()
            .unwrap();

        let generated_verilog = options.do_everything().unwrap();

        assert!(generated_verilog.lines().count() > 100);
    }

    #[test]
    fn synthesizing_crate_without_src_and_external_function() {
        let mut options = RustHlsOldBuilder::create_empty()
            .crate_path(PathBuf::from("test_suites/crate_without_src"))
            .function_name("add".into())
            .function_file(
                PathBuf::from("test_suites/test_crate/src/add.rs")
                    .canonicalize()
                    .unwrap(),
            )
            .build()
            .unwrap();

        let generated_verilog = options.do_everything().unwrap();

        assert!(generated_verilog.lines().count() > 100);
    }
}
