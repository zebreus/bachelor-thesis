use std::{env, path::PathBuf};

// /// Locate the that contains the function.
// pub fn locate_macro_call() -> Option<String> {
//     let manifest_dir = env::var("CARGO_MANIFEST_DIR").ok()?;
//     let crate_name = env::var("CARGO_CRATE_NAME").ok()?;

//     let macro_call = proc_macro::Span::call_site().source_text()?;

//     let mut path = std::path::PathBuf::from(manifest_dir).canonicalize().ok()?;

//     Some(String::from(""))
// }

use thiserror::Error;

use std::io;

use tempfile::NamedTempFile;

pub fn generate_file_from_stream(input: proc_macro::TokenStream) -> io::Result<NamedTempFile> {
    let temp_file = NamedTempFile::new()?;
    let temp_file_path = temp_file.path().to_path_buf();

    let content = input.to_string();
    std::fs::write(temp_file_path, content)?;

    Ok(temp_file)
}

#[derive(Error, Debug)]
pub enum LocationError {
    // #[error("Failed to the file that called the macro (got \"{source_file}\"))")]
    // FailedToGetCallSite { source_file: String },
    #[error("Failed to find crate directory because CARGO_MANIFEST_DIR is not set")]
    CargoManifestDirNotSet,
    #[error("Failed to open crate directory because it does not exist at ({path})")]
    CargoManifestDirDoesNotExist { path: String },
    #[error("Failed to generate temporary file")]
    FailedToGenerateTempFile(#[from] io::Error),
}

pub struct LocationInformation {
    pub crate_directory: PathBuf,
    pub function_file: PathBuf,
    _temp_file: Option<NamedTempFile>,
}

/// Locate the that contains the function.
pub fn locate_macro_call(
    input: proc_macro::TokenStream,
) -> Result<LocationInformation, LocationError> {
    let manifest_dir =
        env::var("CARGO_MANIFEST_DIR").or(Err(LocationError::CargoManifestDirNotSet))?;
    let path = std::path::PathBuf::from(&manifest_dir)
        .canonicalize()
        .or(Err(LocationError::CargoManifestDirDoesNotExist {
            path: manifest_dir,
        }))?;

    // let source_file = proc_macro::Span::call_site().source_file().path();
    let source_file = PathBuf::from("");
    let source_file = source_file.canonicalize();

    if let Ok(source_file) = source_file {
        return Ok(LocationInformation {
            crate_directory: path,
            function_file: source_file,
            _temp_file: None,
        });
    }

    let temp_file = generate_file_from_stream(input)?;
    // .or(Err(LocationError::FailedToGetCallSite {
    //     source_file: source_file.to_string_lossy().to_string(),
    // }))?;

    Ok(LocationInformation {
        crate_directory: path,
        function_file: temp_file.path().to_path_buf(),
        _temp_file: Some(temp_file),
    })
}
