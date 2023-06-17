mod process_module;
use std::{io, path::PathBuf};

use process_module::*;
mod find_modules;
use find_modules::*;
mod perform_hls;

use thiserror::Error;

use self::perform_hls::PerformHlsError;
#[derive(Error, Debug)]
pub enum HlsBuildscriptError {
    #[error(transparent)]
    FindModulesError(#[from] FindModulesError),
    #[error(transparent)]
    ProcessModulesError(#[from] ProcessModuleError),
    #[error("Crate root does not exist {path}")]
    FailedToFindCrateRoot { path: String },
    #[error(transparent)]
    PerformHlsError(#[from] PerformHlsError),
    #[error(transparent)]
    IoError(#[from] io::Error),
}

pub fn buildscript_hls(root: &PathBuf) -> Result<(), HlsBuildscriptError> {
    let root = root
        .canonicalize()
        .or(Err(HlsBuildscriptError::FailedToFindCrateRoot {
            path: root.to_string_lossy().to_string(),
        }))?;

    let found_modules = find_modules(&root)?;

    for module in found_modules {
        let result = perform_hls::perform_hls(&module)?;
        for mut file in result {
            file.path = root.join(&file.path);
            eprintln!("Writing file: {:?}", file.path);
            file.write()?;
        }
    }

    Ok(())
}
