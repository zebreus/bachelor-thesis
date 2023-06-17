use std::path::PathBuf;

use crate::{
    calculate_hash, generate_hls_script::GenerateHlsOptions, rust_hls::CrateFile, RustHls,
};

use super::find_modules::MacroModule;
use thiserror::Error;
mod analyze_dependencies;
pub use analyze_dependencies::*;
mod get_available_dependencies;
pub use get_available_dependencies::*;
mod find_main_function;
pub use find_main_function::*;
mod generate_cargo_toml;
pub use generate_cargo_toml::*;
mod remove_hls_macros;
pub use remove_hls_macros::*;

#[derive(Error, Debug)]
pub enum ProcessModuleError {
    #[error(transparent)]
    AnalyzeDependenciesError(#[from] AnalyzeDependenciesError),
    #[error(transparent)]
    GetDependenciesError(#[from] GetDependenciesError),
    #[error(transparent)]
    FindFunctionNameError(#[from] FindFunctionNameError),
    #[error(transparent)]
    GenerateCargoTomlError(#[from] GenerateCargoTomlError),
    #[error(transparent)]
    RemoveHlsMacrosError(#[from] RemoveHlsMacrosError),
}

// TODO: Passthrough features and patch from Cargo.toml

/// A macro module that has been checked and processed that it is most likley synthesizable
///
/// It should not be neccessary to analyze the module further as this type should contain all information required to build a crate and run bambu
#[derive(Debug, Hash)]
pub struct ProcessedModule {
    /// Content of the module
    pub content: String,
    /// The main function name
    pub function_name: String,
    /// The dependencies that are required to build the module
    pub cargo_toml: String,
    /// Arguments for rust_hls
    pub rust_hls_args: super::HlsArguments,
    /// The parameters of the function
    pub parameters: Vec<(String, syn::Type)>,
}

impl ProcessedModule {
    pub fn get_files(&self) -> Vec<CrateFile> {
        let mut files = Vec::new();
        files.push(CrateFile {
            path: PathBuf::from("Cargo.toml"),
            content: self.cargo_toml.clone(),
        });
        files.push(CrateFile {
            path: PathBuf::from("src/lib.rs"),
            content: self.content.clone(),
        });
        return files;
    }

    pub fn calculate_hash(&self) -> String {
        let files = self.get_files();
        let hash = calculate_hash(&files);
        return hash;
    }

    // TODO: Refactor rust hls args and GenerateHlsOptions

    pub fn to_rust_hls(&self) -> RustHls {
        let files = self.get_files();

        let options = GenerateHlsOptions {
            function_name: self.function_name.clone(),
            rust_flags: self
                .rust_hls_args
                .rust_flags
                .clone()
                .and_then(|f| Some(f.value())),
            hls_flags: self
                .rust_hls_args
                .hls_flags
                .clone()
                .and_then(|f| Some(f.value())),
        };

        let rust_hls = RustHls::new(files, options);
        return rust_hls;
    }
}

pub fn process_module(module: &MacroModule) -> Result<ProcessedModule, ProcessModuleError> {
    let available_dependencies = get_available_dependencies(&module.cargo_toml)?;
    let dependencies = analyze_dependencies(&module, &available_dependencies)?;
    let HlsFunctionInfo {
        function_name,
        hls_arguments,
        parameters,
    } = find_main_function(&module.module_content)?;
    let hls_args = module.hls_arguments.overlay(&hls_arguments);
    let cargo_toml = generate_cargo_toml(&module.crate_root, &module.cargo_toml, &dependencies)?;

    // Create a mutable copy of content, so we can remove the hls! macro
    let mut new_content = module.module_content.clone();
    remove_hls_macros(&mut new_content)?;

    let processed_module = ProcessedModule {
        content: prettyplease::unparse(&new_content),
        function_name,
        cargo_toml: cargo_toml.content,
        rust_hls_args: hls_args,
        parameters: parameters,
    };
    return Ok(processed_module);
}
