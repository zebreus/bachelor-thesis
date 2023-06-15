mod process_modules;
use std::path::PathBuf;

use process_modules::*;
mod find_modules;
use find_modules::*;
mod perform_hls;

use thiserror::Error;
#[derive(Error, Debug)]
pub enum HlsBuildscriptError {
    #[error(transparent)]
    FindModulesError(#[from] FindModulesError),
    #[error(transparent)]
    ProcessModulesError(#[from] ProcessModulesError),
}

pub fn buildscript_hls(root: &PathBuf) -> Result<(), HlsBuildscriptError> {
    let found_modules = find_modules(root)?;
    let processed_modules = process_modules(found_modules)?;
    Ok(())
}
