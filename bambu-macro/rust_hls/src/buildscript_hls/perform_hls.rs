use std::path::PathBuf;

use crate::{
    buildscript_hls::process_module::process_module,
    generated_file::{
        generate_file, generate_output_filename, generate_verilog_file,
        generate_verilog_output_filename, ExtractHashError, ExtractModulePathError,
        GenerateRustHdlStructError,
    },
    rust_hls::CrateFile,
    RustHlsError,
};

use super::{find_modules::MacroModule, process_module::ProcessModuleError};

use itertools::Itertools;
use rust_hls_macro_lib::synthesized_struct_name;
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
    #[error(transparent)]
    FailedToGenerateOutputFile(#[from] GenerateRustHdlStructError),
}

pub enum PerformHlsResult {
    Cached {
        synthesized_file: PathBuf,
        verilog_file: PathBuf,
        function_name: String,
        #[cfg(feature = "verilator")]
        verilated_cpp_file: PathBuf,
    },
    New {
        /// The generated verilog module
        synthesized_file: CrateFile,
        verilog_file: CrateFile,
        function_name: String,
        #[cfg(feature = "verilator")]
        verilated_cpp_file: CrateFile,
    },
}

impl PerformHlsResult {
    #[allow(unused, dead_code)]
    pub fn synthesized_file_path(&self) -> &PathBuf {
        match self {
            Self::Cached {
                synthesized_file, ..
            } => synthesized_file,
            Self::New {
                synthesized_file, ..
            } => &synthesized_file.path,
        }
    }
    #[allow(unused, dead_code)]
    pub fn verilog_file_path(&self) -> &PathBuf {
        match self {
            Self::Cached { verilog_file, .. } => verilog_file,
            Self::New { verilog_file, .. } => &verilog_file.path,
        }
    }
    #[allow(unused, dead_code)]
    pub fn function_name(&self) -> &String {
        match self {
            Self::Cached { function_name, .. } => function_name,
            Self::New { function_name, .. } => function_name,
        }
    }
    #[cfg(feature = "verilator")]
    pub fn verilated_cpp_file_path(&self) -> &PathBuf {
        match self {
            Self::Cached {
                verilated_cpp_file, ..
            } => verilated_cpp_file,
            Self::New {
                verilated_cpp_file, ..
            } => &verilated_cpp_file.path,
        }
    }
}

pub fn perform_hls(module: &MacroModule) -> Result<PerformHlsResult, PerformHlsError> {
    let processed_module = process_module(&module)?;
    let new_hash = processed_module.calculate_hash();

    // Return empty vec if the hashes match
    let input_module_path = &module.absolute_module_path;
    let previous_hash = &module.previous_hash;
    if let Some(previous_hash) = previous_hash {
        if previous_hash == &new_hash {
            return Ok(PerformHlsResult::Cached {
                synthesized_file: generate_output_filename(input_module_path),
                verilog_file: generate_verilog_output_filename(input_module_path),
                function_name: processed_module.function_name.clone(),
                #[cfg(feature = "verilator")]
                verilated_cpp_file: super::generate_verilated_cpp_file_path(
                    input_module_path,
                    &processed_module.function_name,
                ),
            });
        }
    }

    let rust_hls = processed_module.to_rust_hls();

    let result = rust_hls.execute()?;

    let struct_name = synthesized_struct_name(&processed_module.function_name);

    let files = generate_file(
        &input_module_path,
        &result.verilog,
        &processed_module.function_name,
        &struct_name,
        &new_hash,
        &processed_module
            .parameters
            .into_iter()
            .map(|(name, _ty)| name)
            .collect_vec(),
    )?;

    let verilog_file = generate_verilog_file(&input_module_path, result.verilog);

    #[cfg(feature = "verilator")]
    {
        // let verilogShim
    }

    return Ok(PerformHlsResult::New {
        synthesized_file: files.0,
        verilog_file: verilog_file,
        function_name: processed_module.function_name,
        #[cfg(feature = "verilator")]
        verilated_cpp_file: files.1,
    });
}

#[cfg(test)]
mod tests {
    use super::*;
    use quote::quote;

    #[test]
    fn hls_seems_to_work_on_simple_example() {
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

        perform_hls(&module).unwrap();
    }

    #[test]
    fn hls_seems_to_create_synthesized_output() {
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

        perform_hls(&module).unwrap();
        // assert_eq!(result.len(), 1);
        // assert_eq!(
        //     result[0].path.to_str().unwrap(),
        //     format!(
        //         "src/{}.rs",
        //         rust_hls_macro_lib::synthesized_module_name("toast")
        //     )
        // );
        // assert!(result[0].content.contains("pub struct Add"));
        // assert!(result[0].content.contains("Code created using PandA"));
    }
}
