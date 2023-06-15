use std::{fs, path::PathBuf};
use syn::Item;
// /// Returns all source files of the crate
// fn get_source_files(root: &PathBuf) -> Vec<PathBuf> {
//     let base = env::var("CARGO_MANIFEST_DIR").unwrap();
//     let result = vec![String::from(format!("{base}/src/main.rs"))];
//     print!("{:?}", result);
//     result
// }
use thiserror::Error;

use super::{extract_rust_hls_macro, HlsArguments, HlsMacroError};

#[derive(Error, Debug)]
pub enum ExtractModuleError {
    #[error(transparent)]
    HlsMacroError(#[from] HlsMacroError),
    #[error(transparent)]
    IoError(#[from] std::io::Error),
    #[error("Failed to parse file {file}: {message}")]
    FailedToParseFile { file: PathBuf, message: String },
    #[error("Failed to parse macro arguments: {message}")]
    FailedToParseMacroArguments { message: String },
    #[error("You can not use the rust_hls macro on a module import ({file} {module})")]
    RustHlsMacroOnModuleImport { file: String, module: String },
    #[error("You can only have a single hls macro on a module. ({file} {module})")]
    MultipleRustHlsMacrosOnModule { file: String, module: String },
}

/// Parse a file at a path into a syn AST
fn parse_file(source_file: &PathBuf) -> Result<syn::File, ExtractModuleError> {
    let content = fs::read_to_string(&source_file)?;
    let parsed_file = syn::parse_file(content.as_str()).or_else(|err| {
        Err(ExtractModuleError::FailedToParseFile {
            file: source_file.clone(),
            message: err.to_string(),
        })
    })?;
    Ok(parsed_file)
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum ModuleType {
    /// Submodule in the same file
    Inline,
}

/// A module that contains a macro function.
#[derive(Debug, PartialEq, Eq, Clone)]
pub struct MacroModule {
    /// Content of the macro call module
    pub module_content: syn::File,
    /// Content of the macro call module as a stringified syn::File
    pub module_content_string: String,
    /// The arguments that should be used when converting the macro
    pub hls_arguments: HlsArguments,
    /// Path to the original file that contains the macro call
    pub source_file: PathBuf,
    /// Path to the original crate root
    pub crate_root: PathBuf,
    /// Path to the module in the original file. Like "something::something::module_name"
    pub module_path: String,
    /// Name of the module, if available
    pub module_name: String,
    /// Original type of the module
    pub module_type: ModuleType,
}

// Rust-hls rules
// No external mods
// No references to the same crate
// No using mod to add external modules
/// Extracts a module from an item, if it is a Item::Mod. Otherwise returns an empty vector.
///
fn extract_module_from_item(
    item: &syn::Item,
    crate_root: &PathBuf,
    file: &PathBuf,
    current_module_path: &str,
) -> Result<Vec<MacroModule>, ExtractModuleError> {
    match item {
        Item::Macro(_)
        | Item::Const(_)
        | Item::Fn(_)
        | Item::Static(_)
        | Item::Struct(_)
        | Item::Trait(_)
        | Item::TraitAlias(_)
        | Item::Type(_)
        | Item::Union(_)
        | Item::Use(_)
        | Item::Verbatim(_)
        | Item::ExternCrate(_)
        | Item::ForeignMod(_)
        | Item::Impl(_)
        | Item::Enum(_) => Ok(Vec::new()),
        Item::Mod(module) => {
            let module_name = module.ident.to_string();

            let current_module_path = if current_module_path.len() == 0 {
                module_name.clone()
            } else {
                format!("{current_module_path}::{module_name}")
            };

            let rust_hls_options = extract_rust_hls_macro(&module.attrs)?;

            let Some(rust_hls_arguments) = rust_hls_options else {
                // Could not find a rust-hls macro
                let thing: Result<Vec<MacroModule>, ExtractModuleError> = match &module.content {
                    Some((_, items)) => extract_hls_modules(&items, crate_root, file, &current_module_path),
                    None => Ok(Vec::new()),
                };
                return thing;
            };

            let Some(module_content) = &module.content else {
                return Err(ExtractModuleError::RustHlsMacroOnModuleImport {
                    module: current_module_path.into(),
                    file: file.to_string_lossy().to_string(),
                })
            };

            let module_file = syn::File {
                shebang: None,
                attrs: Vec::new(),
                items: module_content.1.clone(),
            };

            let result: Result<Vec<MacroModule>, ExtractModuleError> = Ok(vec![MacroModule {
                module_content_string: prettyplease::unparse(&module_file),
                module_content: module_file,
                source_file: file.clone(),
                crate_root: crate_root.clone(),
                module_path: current_module_path.to_string(),
                module_name: module_name,
                hls_arguments: rust_hls_arguments,
                module_type: ModuleType::Inline,
            }]);

            result
        }
        _ => Ok(Vec::new()) as Result<Vec<MacroModule>, ExtractModuleError>,
    }
}

/// Finds all modules that look like they are rust-hls modules in this file.
pub fn extract_hls_modules(
    items: &Vec<syn::Item>,
    crate_root: &PathBuf,
    file: &PathBuf,
    current_module_path: &str,
) -> Result<Vec<MacroModule>, ExtractModuleError> {
    items
        .iter()
        .map(|item| {
            let modules = extract_module_from_item(item, crate_root, file, current_module_path);
            modules
        })
        .try_fold(Vec::new(), |mut acc, f| {
            let Ok(macro_modules) = f else {return f};
            acc.extend(macro_modules.into_iter());
            Ok(acc)
        })
}

pub fn extract_modules_from_file(
    crate_root: &PathBuf,
    file: &PathBuf,
) -> Result<Vec<MacroModule>, ExtractModuleError> {
    let source_file = crate_root.join(file);
    let parsed_file = parse_file(&source_file).or_else(|err| {
        Err(ExtractModuleError::FailedToParseFile {
            file: source_file.clone(),
            message: err.to_string(),
        })
    })?;
    let items = parsed_file.items;

    extract_hls_modules(&items, crate_root, file, "")
}

#[cfg(test)]
mod tests {
    use super::*;
    use glob::glob;

    const TEST_FILES_ROOT: &str = "test_suites/test_files";

    #[test]
    fn all_test_files_are_valid() {
        let valid_files: Result<Vec<PathBuf>, _> =
            glob(format!("{TEST_FILES_ROOT}/src/valid/*.rs").as_str())
                .expect("Failed to read glob pattern")
                .collect();

        for file in valid_files.expect("Failed when checking globbed files") {
            extract_modules_from_file(
                &PathBuf::from(TEST_FILES_ROOT),
                &PathBuf::from(
                    file.strip_prefix(TEST_FILES_ROOT)
                        .expect("Failed to root prefix"),
                ),
            )
            .expect(format!("Failed to extract modules from file {:?}", file).as_str());
        }
    }

    #[test]
    fn finds_one_module_if_there_is_only_one() {
        let root = PathBuf::from(TEST_FILES_ROOT);
        let file_with_one_hls_module = PathBuf::from("src/valid/file_with_one_hls_module.rs");

        let result = extract_modules_from_file(&root, &file_with_one_hls_module).unwrap();

        assert_eq!(result.len(), 1);
        let module = result.first().unwrap();
        assert_eq!(module.module_name, "hls_module");
        assert_eq!(module.module_path, "hls_module");
        assert_eq!(module.source_file, root.join(file_with_one_hls_module));
    }

    #[test]
    fn detects_inline_modules() {
        let root = PathBuf::from(TEST_FILES_ROOT);
        let file_with_one_hls_module = PathBuf::from("src/valid/file_with_one_hls_module.rs");

        let result = extract_modules_from_file(&root, &file_with_one_hls_module).unwrap();

        assert_eq!(result.len(), 1);
        let module = result.first().unwrap();
        assert_eq!(module.module_type, ModuleType::Inline);
    }

    #[test]
    fn finds_two_modules_in_a_file_with_two_modules_also_they_are_ordered_correctly() {
        let root = PathBuf::from(TEST_FILES_ROOT);
        let file_with_two_hls_modules = PathBuf::from("src/valid/file_with_two_hls_modules.rs");

        let result = extract_modules_from_file(&root, &file_with_two_hls_modules).unwrap();

        assert_eq!(result.len(), 2);
        let module = result.get(0).unwrap();
        assert_eq!(module.module_name, "hls_module_a");
        assert_eq!(module.module_path, "hls_module_a");
        assert_eq!(module.source_file, root.join(&file_with_two_hls_modules));

        let module = result.get(1).unwrap();
        assert_eq!(module.module_name, "hls_module_b");
        assert_eq!(module.module_path, "hls_module_b");
        assert_eq!(module.source_file, root.join(&file_with_two_hls_modules));
    }

    #[test]
    fn finds_no_modules_if_there_are_none() {
        let root = PathBuf::from(TEST_FILES_ROOT);
        let module_without_macro = PathBuf::from("src/valid/module_without_macro.rs");

        let result = extract_modules_from_file(&root, &module_without_macro).unwrap();

        assert_eq!(result.len(), 0);
    }

    #[test]
    fn finds_modules_even_if_they_dont_have_a_hls_function() {
        let root = PathBuf::from(TEST_FILES_ROOT);

        let file_with_hls_module_without_hls_function =
            PathBuf::from("src/valid/file_with_hls_module_without_hls_function.rs");
        let result =
            extract_modules_from_file(&root, &file_with_hls_module_without_hls_function).unwrap();
        assert_eq!(result.len(), 1);

        let file_with_hls_module_without_function =
            PathBuf::from("src/valid/file_with_hls_module_without_function.rs");
        let result =
            extract_modules_from_file(&root, &file_with_hls_module_without_function).unwrap();
        assert_eq!(result.len(), 1);
    }
}
