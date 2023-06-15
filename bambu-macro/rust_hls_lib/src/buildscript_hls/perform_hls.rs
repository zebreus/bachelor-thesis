use std::path::PathBuf;

use super::process_modules::ProcessedModule;

use thiserror::Error;

#[derive(Error, Debug)]
pub enum PerformHlsError {
    #[error("Failed HLS error")]
    FailedHlsError(),
}

struct HlsTask {
    /// The module that will be processed by this task
    module: ProcessedModule,
    /// The path to the output file
    output_dir: PathBuf,
    /// The output crate root
    crate_root: PathBuf,
}

struct HlsTaskResult {
    /// Where the output file will be located
    file: PathBuf,
    /// The content of the output file
    content: String,
    // How the result was achieved
    // signal cache use
}

impl HlsTask {
    pub fn new(module: ProcessedModule) -> Self {
        // Self { module }
        todo!()
    }
    pub fn execute(&self) -> Result<HlsTaskResult, PerformHlsError> {
        todo!()
    }
}
