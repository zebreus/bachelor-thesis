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

#[derive(Error, Debug)]
pub enum LocationError {
    #[error("Failed to find crate directory")]
    FailedToFindManifestDir,
    #[error("Failed to the file that called the macro")]
    FailedToGetCallSite,
}

pub struct LocationInformation {
    pub crate_directory: PathBuf,
    pub function_file: PathBuf,
}

/// Locate the that contains the function.
pub fn locate_macro_call() -> Result<LocationInformation, LocationError> {
    let manifest_dir =
        env::var("CARGO_MANIFEST_DIR").or(Err(LocationError::FailedToFindManifestDir))?;
    let path = std::path::PathBuf::from(manifest_dir)
        .canonicalize()
        .or(Err(LocationError::FailedToFindManifestDir))?;

    let source_file = proc_macro::Span::call_site()
        .source_file()
        .path()
        .canonicalize()
        .or(Err(LocationError::FailedToGetCallSite))?;

    Ok(LocationInformation {
        crate_directory: path,
        function_file: source_file,
    })
}
