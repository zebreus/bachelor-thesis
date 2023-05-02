use std::{
    fs::{self, File},
    io::Write,
    path::PathBuf,
};

use cargo_toml::Manifest;
use serde::Serialize;

use crate::extract_function_crate::ExtractCrateError;

pub fn sanitize_cargo_toml(
    target_crate_path: &PathBuf,
    original_crate_path: &PathBuf,
) -> Result<String, ExtractCrateError> {
    let cargo_toml_path = &target_crate_path.join("Cargo.toml");
    eprintln!("Sanitizing Cargo.toml at {:?}", cargo_toml_path);
    if !cargo_toml_path.exists() {
        return Err(ExtractCrateError::NoCargoToml);
    }

    if !original_crate_path.join("Cargo.toml").exists() {
        return Err(ExtractCrateError::NoCargoToml);
    }

    let cargo_toml_content = fs::read(cargo_toml_path)?;
    let mut manifest = Manifest::from_slice(cargo_toml_content.as_slice())?;

    // Remove all executables
    manifest.bin = Vec::new();

    // Make sure the crate is no workspace
    manifest.workspace = None;

    let Some(package) = manifest.package.as_mut() else  {
        return Err(ExtractCrateError::CrateHasNoPackageField());
    };
    let name = package.name.clone();

    // TODO: We need unique package names for workspaces to work. But they also kill the cache.
    // One solution woult be to leave the name as is, but move the Cargo.toml to Cargo.toml.inactive before caching
    // The build script would then rename it to Cargo.toml and generate a new name
    //
    // Another solution would be to generate the name for the new crate after the cache key generation. This is what we currently do.

    // Make paths to dependencies relative to the original Cargo.toml
    let dependencies = &mut manifest.dependencies;
    dependencies.iter_mut().for_each(|dependency| {
        let (key, dep) = dependency;
        let path = &mut dep.detail_mut().path;
        if let Some(path) = path {
            let fixed_path = original_crate_path
                .join(path.as_str())
                .to_str()
                .unwrap()
                .to_string();
            *path = fixed_path;
        }
        // Checking only by key may not be enough.
        if key == "rust_hls" {
            dep.detail_mut().default_features = false;
        }
    });

    let mut buffer = String::new();
    let serializer = toml::Serializer::new(&mut buffer);
    manifest.serialize(serializer)?;

    File::create(cargo_toml_path)?.write_all(buffer.as_bytes())?;

    Ok(name)
}

#[cfg(test)]
mod tests {

    use std::{path::Path, process::Command};

    use tempfile::TempDir;

    use crate::extract_function_crate::copy_crate;

    use super::*;

    #[test]
    fn crate_with_relative_path_dependency_get_fixed() {
        let dir = TempDir::new().unwrap();

        let target_crate_path = dir.path().to_path_buf();
        let original_crate_path = Path::new("test_suites/crate_with_path_dependency")
            .to_path_buf()
            .canonicalize()
            .unwrap();

        copy_crate(&original_crate_path, &target_crate_path).unwrap();

        let output = Command::new("cargo")
            .arg("build")
            .current_dir(&target_crate_path)
            .output()
            .unwrap();
        if output.status.success() {
            panic!("Should fail to build before fixing cargo toml if the path to a dependency is relative");
        }

        sanitize_cargo_toml(&target_crate_path, &original_crate_path).unwrap();

        let output = Command::new("cargo")
            .arg("build")
            .current_dir(&target_crate_path)
            .output()
            .unwrap();
        if !output.status.success() {
            panic!("Should not fail building after fixing cargo toml if the path to a dependency is relative");
        }

        assert!(target_crate_path.join("Cargo.toml").exists());
    }
}
