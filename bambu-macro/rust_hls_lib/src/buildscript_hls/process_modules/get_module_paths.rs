use std::path::{Component, PathBuf};

use crate::buildscript_hls::find_modules::MacroModule;

use itertools::Itertools;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum GetModulePathsError {
    #[error("Expected path {filename:?} to start with src. Currently only paths like src/**/*.rs are supported.")]
    ExpectedPathToStartWithSrc { filename: String },
    #[error("Expected path {filename:?} to only contain normal components (not . or ..). Currently only paths like src/**/*.rs are supported.")]
    ExpectedPathToOnlyContainNormalComponents { filename: String },
    #[error("Expected path {filename:?} to end with .rs. Currently only paths like src/**/*.rs are supported.")]
    PathDoesNotEndWithRs { filename: String },
}

/// Converts a PathBuf into the parts of a module path.
///
/// Example: src/foo/bar.rs -> ["foo", "bar"]
pub fn file_to_module_path(file: &PathBuf) -> Result<Vec<String>, GetModulePathsError> {
    let mut components = file.components();
    let Some(Component::Normal(src_component)) = components.next() else {
        return Err(GetModulePathsError::ExpectedPathToStartWithSrc {
            filename: file.to_string_lossy().to_string()
        });
    };
    if src_component.to_string_lossy().to_string() != "src" {
        return Err(GetModulePathsError::ExpectedPathToStartWithSrc {
            filename: file.to_string_lossy().to_string(),
        });
    }
    let mut remaining_components = components
        .map(|component| match component {
            Component::Normal(component) => Ok(component.to_string_lossy().to_string()),
            _ => Err(
                GetModulePathsError::ExpectedPathToOnlyContainNormalComponents {
                    filename: file.to_string_lossy().to_string(),
                },
            ),
        })
        .collect::<Result<Vec<_>, _>>()?;

    let last_part = remaining_components.pop().unwrap_or(String::from(""));
    let Some(last_part) = last_part.strip_suffix(".rs") else {
            return Err(GetModulePathsError::PathDoesNotEndWithRs {
                filename: file.to_string_lossy().to_string(),
            });
        };
    remaining_components.push(last_part.into());

    let Some(first_part) = remaining_components.first().cloned() else {
       return  Ok(remaining_components);
    };
    if first_part == "lib" {
        remaining_components.remove(0);
    }
    if first_part == "main" {
        remaining_components.remove(0);
    }

    Ok(remaining_components)
}

pub fn module_path_string_to_vec(
    mut module_path: String,
) -> Result<Vec<String>, GetModulePathsError> {
    let parts = module_path
        .split("::")
        .map(|part| part.to_string())
        .collect::<Vec<_>>();
    Ok(parts)
}

pub struct ModulePathInformation {
    pub input_file: PathBuf,
    pub output_file: PathBuf,
    /// Path to the source file
    pub module_path_to_file: Vec<String>,
    /// Module path to the output file
    pub module_path_in_file: Vec<String>,
    /// Absolute path to the input module.
    pub absolute_input_module_path: Vec<String>,
    /// Absolute path to the output module.
    pub absolute_module_path: Vec<String>,
}

/// This function calculates information about the module path of a module.
///
/// Arguments:
/// * `source_file`: The path to the source file of the module. Relative to the crate root
/// * `module_path`: The path to the module inside the source file
/// * `function_name`: The name of the function that is being synthesized
pub fn get_module_path_information(
    source_file: &PathBuf,
    module_path: &String,
    function_name: &String,
) -> Result<ModulePathInformation, GetModulePathsError> {
    let module_path_to_file = file_to_module_path(&source_file)?;
    let module_path_in_file = module_path_string_to_vec(module_path.clone())?;
    let absolute_input_module_path = module_path_to_file
        .iter()
        .chain(module_path_in_file.iter())
        .map(|part| part.to_string())
        .collect::<Vec<String>>();

    let mut absolute_module_path = absolute_input_module_path.clone();
    let last_module = absolute_module_path.pop().unwrap_or("lib".into());
    absolute_module_path.push(format!("{last_module}_synthesized"));

    let input_file = source_file.clone();
    let output_file = PathBuf::from(format!(
        "src/{}.rs",
        absolute_module_path
            .iter()
            .map(|part| format!("{part}").to_string())
            .join("/")
    ));
    return Ok(ModulePathInformation {
        input_file,
        output_file,
        module_path_in_file,
        module_path_to_file,
        absolute_input_module_path,
        absolute_module_path,
    });
    // let
}
