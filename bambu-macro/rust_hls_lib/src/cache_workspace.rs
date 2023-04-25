use std::{
    fs::{self, OpenOptions},
    io::Write,
    path::PathBuf,
};

use cargo_toml::Manifest;

use fslock::LockFile;
use serde::Serialize;

use crate::{caching::get_cache_path, RustHlsError};

pub fn add_to_workspace(working_directory: &PathBuf) -> Result<(), RustHlsError> {
    let workspace_cargo_toml_path = get_cache_path()?.join("Cargo.toml");

    let cargo_toml_content = fs::read(&workspace_cargo_toml_path).unwrap_or(
        r#"
    [workspace]
    members = []
    exclude = ["target", "target/*"]
    "#
        .into(),
    );

    let mut manifest = Manifest::from_slice(cargo_toml_content.as_slice())?;
    let Some(workspace) = manifest.workspace.as_mut() else  {
                return Err(RustHlsError::FailedToAccessWorkspacePackage);
            };
    let working_directory_string = working_directory.to_str().unwrap().into();
    if !workspace.members.contains(&working_directory_string) {
        workspace.members.push(working_directory_string);
    }
    workspace
        .members
        .retain_mut(|member| PathBuf::from(&member).exists());
    let mut buffer = String::new();
    let serializer = toml::Serializer::new(&mut buffer);
    manifest.serialize(serializer)?;
    // file.set_len(0)?;

    let mut file = OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true)
        .open(&workspace_cargo_toml_path)?;

    file.write_all(buffer.as_bytes())?;
    file.sync_all()?;
    file.flush()?;

    Ok(())
}

pub struct WorkspaceLock {
    lockfile: LockFile,
}

impl WorkspaceLock {
    pub fn new() -> Result<WorkspaceLock, RustHlsError> {
        let cache_path = get_cache_path()?;
        let lockfile_path = cache_path.join("Cargo.toml.lock");
        let mut lockfile = LockFile::open(&lockfile_path)?;
        lockfile.lock()?;
        // eprintln!("#################### Entering locked region");
        Ok(WorkspaceLock { lockfile })
    }

    pub fn unlock(mut self) {
        // eprintln!("#################### Leaving locked region");
        self.lockfile.unlock().unwrap_or(());
    }
}
