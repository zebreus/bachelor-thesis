use super::find_modules::MacroModule;
use thiserror::Error;
mod analyze_dependencies;
pub use analyze_dependencies::*;
mod get_available_dependencies;
pub use get_available_dependencies::*;
mod find_function_name;
pub use find_function_name::*;

#[derive(Error, Debug)]
pub enum ProcessModulesError {
    #[error(transparent)]
    AnalyzeDependenciesError(#[from] AnalyzeDependenciesError),
    #[error(transparent)]
    GetDependenciesError(#[from] GetDependenciesError),
    #[error(transparent)]
    FindFunctionNameError(#[from] FindFunctionNameError),
}

// TODO: Passthrough features and patch from Cargo.toml

/// A macro module that has been checked and processed that it is most likley synthesizable
///
/// It should not be neccessary to analyze the module further as this type should contain all information required to build a crate and run bambu
pub struct ProcessedModule {
    /// Content of the module
    pub content: String,
    /// The main function name
    pub function_name: String,
    /// The name of the module
    pub module_name: String,
    /// The dependencies that are required to build the module
    pub dependencies: Vec<String>,
    /// Arguments for rust_hls
    pub rust_hls_args: super::HlsArguments,
}

pub fn process_module(module: MacroModule) -> Result<ProcessedModule, ProcessModulesError> {
    let available_dependencies = get_available_dependencies(&module.crate_root)?;
    let dependencies = analyze_dependencies(&module, &available_dependencies)?;
    let (function_name, function_hls_arguments) = find_function_name(&module.module_content)?;
    let hls_args = module.hls_arguments.overlay(&function_hls_arguments);
    let processed_module = ProcessedModule {
        content: module.module_content_string,
        function_name,
        module_name: module.module_name,
        dependencies: dependencies.into_iter().collect(),
        rust_hls_args: hls_args,
    };
    return Ok(processed_module);
}

/// Convert a list of macro modules into a list of processed modules
///
/// Processed modules are modules that are ready to be synthesized.
pub fn process_modules(
    modules: Vec<MacroModule>,
) -> Result<Vec<ProcessedModule>, ProcessModulesError> {
    modules
        .into_iter()
        .map(|module| process_module(module))
        .collect()
}
