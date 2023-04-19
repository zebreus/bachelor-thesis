use std::{
    fs::{self, File},
    io::Write,
    path::PathBuf,
};

use cargo_toml::Manifest;
use serde::Serialize;

use crate::extract_function_crate::ExtractCrateError;

pub fn sanitize_cargo_toml(cargo_toml_path: &PathBuf) -> Result<(), ExtractCrateError> {
    if !cargo_toml_path.exists() {
        return Err(ExtractCrateError::NoCargoToml);
    }

    let cargo_toml_content = fs::read(cargo_toml_path)?;
    let mut manifest = Manifest::from_slice(cargo_toml_content.as_slice())?;

    manifest.bin = Vec::new();

    let mut buffer = String::new();
    let serializer = toml::Serializer::new(&mut buffer);
    manifest.serialize(serializer)?;

    File::create(cargo_toml_path)?.write_all(buffer.as_bytes())?;

    Ok(())
}
