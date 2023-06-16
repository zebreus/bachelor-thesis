use std::{
    collections::{BTreeMap, HashSet},
    fs, io,
    path::PathBuf,
};

use cargo_toml::{Dependency, Manifest};
use serde::Serialize;

use thiserror::Error;

use crate::rust_hls::CrateFile;

#[derive(Error, Debug)]
pub enum LoadCargoTomlError {
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error("The source crate does not contain a Cargo.toml file")]
    NoCargoToml,
    #[error("Failed to parse cargo toml for the generated crate")]
    FailedToParseCargoToml(#[from] cargo_toml::Error),
}

#[derive(Error, Debug)]
pub enum GenerateCargoTomlFromManifestError {
    #[error("Failed to parse cargo toml for the generated crate")]
    FailedToParseCargoToml(#[from] cargo_toml::Error),
    #[error("Unable to supply dependencies {dependencies:?}")]
    UnableToSupplyDependencies { dependencies: String },
}

#[derive(Error, Debug)]
pub enum GenerateCargoTomlError {
    #[error("Failed to parse cargo toml for the generated crate")]
    FailedToParseCargoToml(#[from] cargo_toml::Error),
    #[error(transparent)]
    GenerateCargoTomlFromManifestError(#[from] GenerateCargoTomlFromManifestError),
    #[error("Failed to serialize cargo toml for the generated crate")]
    FailedToSerializeCargoToml(#[from] toml::ser::Error),
}

/// Load the cargo toml of the crate at the given path
pub fn load_cargo_toml(crate_root: &PathBuf) -> Result<Manifest, LoadCargoTomlError> {
    let cargo_toml_path = &crate_root.join("Cargo.toml");
    if !cargo_toml_path.exists() {
        return Err(LoadCargoTomlError::NoCargoToml);
    }

    let cargo_toml_content = fs::read(cargo_toml_path)?;
    let manifest = Manifest::from_slice(cargo_toml_content.as_slice())?;

    return Ok(manifest);
}

/// Generates a new cargo.toml file for the generated crate.
///
/// The crate_root is required to fix relative path dependencies.
///
/// The new crate will alwasy be named "__CRATE_NAME__" and have version "1.0.0".
pub fn generate_cargo_toml_from_manifest(
    crate_root: &PathBuf,
    original_cargo_toml: &Manifest,
    required_dependencies: &HashSet<String>,
) -> Result<Manifest, GenerateCargoTomlFromManifestError> {
    let original_manifest = original_cargo_toml.clone();

    let mut new_manifest = Manifest::from_str(
        format!(
            r#"[package]
name = "__CRATE_NAME__"
version = "1.0.0"
edition = "2021"
description = "Temporary crate created by rust_hls""#
        )
        .as_str(),
    )?;

    // Copy edition from original crate
    if let Some(original_package) = original_manifest.package {
        let original_edition = original_package.edition;
        let mut new_package = new_manifest.package().clone();
        new_package.edition = original_edition;
        new_manifest.package = Some(new_package);
    }

    let mut not_added_dependencies = required_dependencies.clone();

    // Copy dependencies from original crate
    let dependencies: BTreeMap<String, Dependency> = original_manifest
        .dependencies
        .into_iter()
        .map(|dependency| {
            // Fix dependency paths
            let (key, mut dep) = dependency;
            let path = &mut dep.detail_mut().path;
            if let Some(path) = path {
                let fixed_path = crate_root.join(path.as_str()).to_str().unwrap().to_string();
                *path = fixed_path;
            }
            // Checking only by key may not be enough.
            if key == "rust_hls" {
                dep.detail_mut().default_features = false;
            }
            (key, dep)
        })
        .filter(|dependency| {
            let (key, _dep) = dependency;
            if not_added_dependencies.contains(key) {
                not_added_dependencies.remove(key);
                return true;
            }
            return false;
        })
        .collect();

    if not_added_dependencies.len() != 0 {
        return Err(
            GenerateCargoTomlFromManifestError::UnableToSupplyDependencies {
                dependencies: not_added_dependencies
                    .into_iter()
                    .collect::<Vec<String>>()
                    .join(", "),
            },
        );
    }

    new_manifest.dependencies = dependencies;

    return Ok(new_manifest);
}

pub fn generate_cargo_toml(
    crate_root: &PathBuf,
    cargo_toml: &String,
    required_dependencies: &HashSet<String>,
) -> Result<CrateFile, GenerateCargoTomlError> {
    let original_manifest = Manifest::from_str(cargo_toml.as_str())?;

    let new_manifest =
        generate_cargo_toml_from_manifest(crate_root, &original_manifest, required_dependencies)?;

    let mut buffer = String::new();
    let serializer = toml::Serializer::new(&mut buffer);
    new_manifest.serialize(serializer)?;

    return Ok(CrateFile {
        path: PathBuf::from("Cargo.toml"),
        content: buffer,
    });
}
