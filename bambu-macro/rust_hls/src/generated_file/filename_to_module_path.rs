use itertools::Itertools;
use std::path::{Component, PathBuf};
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ExtractModulePathError {
    #[error("Expected path {filename:?} to start with src. Currently only paths like src/**/*.rs are supported.")]
    ExpectedPathToStartWithSrc { filename: String },
    #[error("Expected path {filename:?} to only contain normal components (not . or ..). Currently only paths like src/**/*.rs are supported.")]
    ExpectedPathToOnlyContainNormalComponents { filename: String },
    #[error("Expected path {filename:?} to end with .rs. Currently only paths like src/**/*.rs are supported.")]
    PathDoesNotEndWithRs { filename: String },
}

/// Generate a filename from a module path
pub fn module_path_to_filename(module_path: &Vec<String>) -> PathBuf {
    let output_file = PathBuf::from(format!(
        "src/{}.rs",
        module_path
            .iter()
            .map(|part| format!("{part}").to_string())
            .join("/")
    ));
    output_file
}

/// Generate a module path from a filename
fn filename_only_to_module_path(filename: &PathBuf) -> Result<Vec<String>, ExtractModulePathError> {
    let mut components = filename.components();
    let Some(Component::Normal(src_component)) = components.next() else {
        return Err(ExtractModulePathError::ExpectedPathToStartWithSrc {
            filename: filename.to_string_lossy().to_string()
        });
    };
    if src_component.to_string_lossy().to_string() != "src" {
        return Err(ExtractModulePathError::ExpectedPathToStartWithSrc {
            filename: filename.to_string_lossy().to_string(),
        });
    }
    let mut remaining_components = components
        .map(|component| match component {
            Component::Normal(component) => Ok(component.to_string_lossy().to_string()),
            _ => Err(
                ExtractModulePathError::ExpectedPathToOnlyContainNormalComponents {
                    filename: filename.to_string_lossy().to_string(),
                },
            ),
        })
        .collect::<Result<Vec<_>, _>>()?;

    let last_part = remaining_components.pop().unwrap_or(String::from(""));
    let Some(last_part) = last_part.strip_suffix(".rs") else {
            return Err(ExtractModulePathError::PathDoesNotEndWithRs {
                filename: filename.to_string_lossy().to_string(),
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

/// Generate a module path from a filename
pub fn filename_to_module_path(
    filename: &PathBuf,
    module_path_in_file: &Vec<String>,
) -> Result<Vec<String>, ExtractModulePathError> {
    let file_module_path = filename_only_to_module_path(filename)?;

    let full_module_path = file_module_path
        .iter()
        .chain(module_path_in_file.iter())
        .cloned()
        .collect::<Vec<_>>();

    Ok(full_module_path)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn conversion_works_in_both_directions() {
        let module_path = vec!["test".into(), "toast".into()];
        let generated_file_name = module_path_to_filename(&module_path);
        let generated_module_path = filename_to_module_path(&generated_file_name, &vec![]).unwrap();

        assert_eq!(module_path, generated_module_path);
    }

    #[test]
    fn module_path_to_filename_works() {
        let module_path = vec!["test".into(), "toast".into()];
        let generated_file_name = module_path_to_filename(&module_path);

        assert_eq!(generated_file_name, PathBuf::from("src/test/toast.rs"));
    }

    #[test]
    fn filename_to_module_path_works() {
        let filename = PathBuf::from("src/test/toast.rs");
        let module_path = vec!["toaster".into()];
        let generated_module_path = filename_to_module_path(&filename, &module_path).unwrap();

        assert_eq!(
            generated_module_path,
            vec![
                "test".to_string(),
                "toast".to_string(),
                "toaster".to_string()
            ]
        );
    }

    #[test]
    fn filename_to_module_path_works_with_lib() {
        // Test without lib
        let filename = PathBuf::from("src/toaster.rs");
        let module_path = vec![];
        let generated_module_path = filename_to_module_path(&filename, &module_path).unwrap();
        assert_eq!(generated_module_path, vec!["toaster".to_string()]);

        // Test with lib
        let filename = PathBuf::from("src/lib.rs");
        let module_path = vec!["toaster".into()];
        let generated_module_path = filename_to_module_path(&filename, &module_path).unwrap();

        assert_eq!(generated_module_path, vec!["toaster".to_string()]);
    }
}
