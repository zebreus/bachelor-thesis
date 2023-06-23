use std::path::PathBuf;

use crate::{
    calculate_hash,
    darling_error_outside_macro::DarlingErrorOutsideMacro,
    generate_hls_script::{generate_hls_script, GenerateHlsOptions},
    rust_hls::CrateFile,
    RustHls,
};

use super::find_modules::MacroModule;
use rust_hls_macro_lib::{parse_hls_macro_module, HlsArguments};
use thiserror::Error;
mod get_available_dependencies;
pub use get_available_dependencies::*;
mod generate_cargo_toml;
pub use generate_cargo_toml::*;
mod make_function_no_mangle;
pub use make_function_no_mangle::*;

#[derive(Error, Debug)]
pub enum ProcessModuleError {
    #[error(transparent)]
    ParseModuleError(#[from] DarlingErrorOutsideMacro),
    #[error(transparent)]
    GetDependenciesError(#[from] GetDependenciesError),
    #[error(transparent)]
    GenerateCargoTomlError(#[from] GenerateCargoTomlError),
    #[error("Failed to get main function. Please report this as a bug.")]
    FailedToGetMainFunction(),
    #[error("Parsed module suddenly changed its mind about having content. Please report this as a bug.")]
    FailedToGetItemsFromModule(),
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
    /// The script that can be called to perform hls
    pub hls_script: String,
    /// Arguments for rust_hls
    pub rust_hls_args: HlsArguments,
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
            path: PathBuf::from("hls.sh"),
            content: self.hls_script.clone(),
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

        let rust_hls = RustHls::new(files);
        return rust_hls;
    }
}

pub fn process_module(module: &MacroModule) -> Result<ProcessedModule, ProcessModuleError> {
    let available_dependencies = get_available_dependencies(&module.cargo_toml)?;
    let mut parsed_module =
        parse_hls_macro_module(module.item_mod.clone(), &available_dependencies).or_else(
            |err| {
                Err(DarlingErrorOutsideMacro::new(
                    &err,
                    &module.crate_root.join(&module.source_file),
                ))
            },
        )?;

    let mut main_function = parsed_module
        .get_main_mut()
        .ok_or(ProcessModuleError::FailedToGetMainFunction())?;

    make_function_no_mangle(&mut main_function);

    let hls_args = module
        .hls_arguments
        .overlay(&parsed_module.main_function_info.hls_arguments);

    let cargo_toml = generate_cargo_toml(
        &module.crate_root,
        &module.cargo_toml,
        &parsed_module.required_dependencies,
    )?;

    let module_file = syn::File {
        shebang: None,
        attrs: Vec::new(),
        items: parsed_module
            .module
            .content
            .ok_or(ProcessModuleError::FailedToGetItemsFromModule())?
            .1,
    };

    let hls_options = GenerateHlsOptions {
        function_name: parsed_module.main_function_info.function_name.clone(),
        hls_arguments: hls_args.clone(),
    };
    let script = generate_hls_script(&hls_options);

    let processed_module = ProcessedModule {
        content: prettyplease::unparse(&module_file),
        function_name: parsed_module.main_function_info.function_name,
        cargo_toml: cargo_toml.content,
        hls_script: script,
        rust_hls_args: hls_args,
        parameters: parsed_module.main_function_info.parameters,
    };
    return Ok(processed_module);
}
