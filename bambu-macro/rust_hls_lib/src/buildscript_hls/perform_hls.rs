use crate::{
    buildscript_hls::process_modules::process_module,
    generated_file::{
        extract_file_hash, filename_to_module_path, generate_file, generate_output_filename,
        ExtractHashError, ExtractModulePathError,
    },
    rust_hls::CrateFile,
    RustHlsError,
};

use super::{find_modules::MacroModule, process_modules::ProcessModuleError};

use convert_case::{Case, Casing};
use thiserror::Error;

#[derive(Error, Debug)]
pub enum PerformHlsError {
    #[error(transparent)]
    ProcessModuleError(#[from] ProcessModuleError),
    #[error(transparent)]
    ExtractModulePathError(#[from] ExtractModulePathError),
    #[error(transparent)]
    ExtractHashError(#[from] ExtractHashError),
    #[error(transparent)]
    RustHlsError(#[from] RustHlsError),
}

pub fn perform_hls(module: &MacroModule) -> Result<Vec<CrateFile>, PerformHlsError> {
    let processed_module = process_module(&module)?;
    let new_hash = processed_module.calculate_hash();

    // Return empty vec if the hashes match
    let input_module_path = &module.absolute_module_path;
    let previous_hash = &module.previous_hash;
    if let Some(previous_hash) = previous_hash {
        if previous_hash == &new_hash {
            return Ok(vec![]);
        }
    }

    let rust_hls = processed_module.to_rust_hls();

    let result = rust_hls.execute()?;

    let struct_name = processed_module.function_name.to_case(Case::Pascal);

    let file = generate_file(
        &input_module_path,
        &result.verilog,
        &processed_module.function_name,
        &struct_name,
        &new_hash,
    );

    return Ok(vec![file]);
}

#[cfg(test)]
mod tests {
    use super::*;
    use quote::quote;

    #[test]
    fn new_for_tests_seems_to_work() {
        let module = MacroModule::new_for_tests(
            quote!(
                #[hls]
                mod toast {
                    #[hls]
                    #[no_mangle]
                    pub extern "C" fn add(a: u32, b: u32) -> u32 {
                        a + b
                    }
                }
            ),
            "src/lib.rs",
        )
        .0;

        let result = perform_hls(&module).unwrap();
    }
}
