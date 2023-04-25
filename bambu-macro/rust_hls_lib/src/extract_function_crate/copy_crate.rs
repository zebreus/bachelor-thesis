use std::{fs::create_dir_all, path::PathBuf};

use fs_extra::{copy_items, dir::CopyOptions};
use itertools::Itertools;

use super::ExtractCrateError;

pub fn copy_crate(
    original_crate_path: &PathBuf,
    target_crate_path: &PathBuf,
) -> Result<(), ExtractCrateError> {
    if !original_crate_path.exists() {
        return Err(ExtractCrateError::SourceCrateDoesNotExist);
    }
    if !original_crate_path.join("Cargo.toml").exists() {
        return Err(ExtractCrateError::NoCargoToml);
    }
    if target_crate_path.join("Cargo.toml").exists() {
        return Err(ExtractCrateError::TargetCrateAlreadyExists);
    }
    create_dir_all(target_crate_path)?;
    // copy(
    //     original_crate_path,
    //     target_crate_path,
    //     &CopyOptions::new().copy_inside(true).content_only(true),
    // )?;

    let files_to_copy = [
        original_crate_path.join("Cargo.toml"),
        original_crate_path.join("Cargo.lock"),
        original_crate_path.join("src"),
    ];
    let files_to_copy = files_to_copy
        .iter()
        .filter(|file| file.exists())
        .collect_vec();
    copy_items(
        &files_to_copy.as_slice(),
        target_crate_path,
        &CopyOptions::new().copy_inside(true),
    )?;
    // file::copy(
    //     original_crate_path,
    //     target_crate_path,
    //     &CopyOptions::new().copy_inside(true).content_only(true),
    // )?;
    // remove_dir_all(target_crate_path.join("target")).unwrap_or(());

    Ok(())
}

#[cfg(test)]
mod tests {

    use std::path::Path;

    use tempfile::TempDir;

    use super::*;

    #[test]
    fn copying_crate_to_nonexisting_dir_works() {
        let dir = TempDir::new().unwrap();

        let target_crate_path = dir.path().join("nonexisting").to_path_buf();
        let original_crate_path = Path::new("test_suites/extract_function_test")
            .to_path_buf()
            .canonicalize()
            .unwrap();

        copy_crate(&original_crate_path, &target_crate_path).unwrap();

        assert!(target_crate_path.join("Cargo.toml").exists());
    }

    #[test]
    fn copying_crate_to_existing_dir_works() {
        let dir = TempDir::new().unwrap();

        let target_crate_path = dir.path().to_path_buf();
        let original_crate_path = Path::new("test_suites/extract_function_test")
            .to_path_buf()
            .canonicalize()
            .unwrap();

        copy_crate(&original_crate_path, &target_crate_path).unwrap();

        assert!(target_crate_path.join("Cargo.toml").exists());
    }
}
