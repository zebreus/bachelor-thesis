use std::{collections::HashSet, fs, io, path::PathBuf};

use cargo_toml::Manifest;

use thiserror::Error;

#[derive(Error, Debug)]
pub enum GetDependenciesError {
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error("The source crate does not contain a Cargo.toml file")]
    NoCargoToml,
    #[error("Failed to parse cargo toml for the generated crate")]
    FailedToParseCargoToml(#[from] cargo_toml::Error),
    #[error("Failed to generate cargo toml for the generated crate")]
    FailedToGenerateCargoToml(#[from] toml::ser::Error),
}

pub fn get_available_dependencies(
    crate_path: &PathBuf,
) -> Result<HashSet<String>, GetDependenciesError> {
    let cargo_toml_path = &crate_path.join("Cargo.toml");
    if !cargo_toml_path.exists() {
        return Err(GetDependenciesError::NoCargoToml);
    }

    let cargo_toml_content = fs::read(cargo_toml_path)?;
    let manifest = Manifest::from_slice(cargo_toml_content.as_slice())?;

    let dependencies = manifest.dependencies;
    let dependency_names_iterator = dependencies.into_iter().map(|dependency| dependency.0);

    let dependency_names = HashSet::from_iter(dependency_names_iterator);
    return Ok(dependency_names);
}

#[cfg(test)]
mod tests {

    use std::path::Path;

    use super::*;

    #[test]
    fn crate_with_relative_path_dependency_get_fixed() {
        let original_crate_path = Path::new("test_suites/crate_with_path_dependency")
            .to_path_buf()
            .canonicalize()
            .unwrap();

        let available_dependencies = get_available_dependencies(&original_crate_path).unwrap();

        assert_eq!(available_dependencies.len(), 1);
        assert!(available_dependencies.contains("test_crate"));
    }
}
