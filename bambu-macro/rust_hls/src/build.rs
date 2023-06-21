use std::path::{Path, PathBuf};

use crate::buildscript_hls;

pub struct Build {
    crate_root: Option<PathBuf>,
}

fn fail(s: &str) -> ! {
    eprintln!("\n{}\n", s);
    std::process::exit(1);
}

#[derive(thiserror::Error, Debug)]
pub enum Error {
    #[error("Failed to automatically find crate root.")]
    CrateRootNotFound,
    #[error(transparent)]
    HlsError(#[from] buildscript_hls::HlsBuildscriptError),
}

impl Build {
    pub fn new() -> Self {
        Self { crate_root: None }
    }
    pub fn crate_root<P: AsRef<Path>>(&mut self, p: P) -> &mut Build {
        self.crate_root = Some(p.as_ref().to_path_buf());
        self
    }
    pub fn synthesize(&self) {
        if let Err(e) = self.try_synthesize() {
            fail(&e.to_string());
        }
    }
    pub fn try_synthesize(&self) -> Result<(), Error> {
        let root = &self
            .crate_root
            .to_owned()
            .or_else(|| {
                std::env::var("CARGO_MANIFEST_DIR")
                    .ok()
                    .map(|c| PathBuf::from(c))
            })
            .and_then(|path| path.canonicalize().ok())
            .ok_or(Error::CrateRootNotFound)?;

        return Ok(buildscript_hls(&root)?);
    }
}
