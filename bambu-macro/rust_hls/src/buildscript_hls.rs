mod process_module;
use std::{io, path::PathBuf};

use process_module::*;
mod find_modules;
use find_modules::*;
mod perform_hls;

#[cfg(feature = "verilator")]
mod generate_verilator_shim;
#[cfg(feature = "verilator")]
pub use generate_verilator_shim::*;

use thiserror::Error;

use self::perform_hls::{PerformHlsError, PerformHlsResult};
#[derive(Error, Debug)]
pub enum HlsBuildscriptError {
    #[error(transparent)]
    FindModulesError(#[from] FindModulesError),
    #[error(transparent)]
    ProcessModulesError(#[from] ProcessModuleError),
    #[error("Crate root does not exist {path}")]
    FailedToFindCrateRoot { path: String },
    #[error(transparent)]
    PerformHlsError(#[from] PerformHlsError),
    #[error(transparent)]
    IoError(#[from] io::Error),
}

pub fn buildscript_hls(root: &PathBuf) -> Result<(), HlsBuildscriptError> {
    let root = root
        .canonicalize()
        .or(Err(HlsBuildscriptError::FailedToFindCrateRoot {
            path: root.to_string_lossy().to_string(),
        }))?;

    let found_modules = find_modules(&root)?;

    for module in found_modules {
        let mut result = perform_hls::perform_hls(&module)?;
        println!(
            "cargo:rerun-if-changed={}",
            module.source_file.to_string_lossy().to_string()
        );
        if let PerformHlsResult::New {
            synthesized_file,
            verilog_file,
            llvm_file,
            log_file,
            #[cfg(feature = "verilator")]
            verilated_cpp_file,
            ..
        } = &mut result
        {
            synthesized_file.path = root.join(&synthesized_file.path);
            synthesized_file.write()?;
            verilog_file.path = root.join(&verilog_file.path);
            verilog_file.write()?;
            if let Some(llvm_file) = llvm_file {
                llvm_file.path = root.join(&llvm_file.path);
                llvm_file.write()?;
            }
            if let Some(log_file) = log_file {
                log_file.path = root.join(&log_file.path);
                log_file.write()?;
            }
            #[cfg(feature = "verilator")]
            {
                verilated_cpp_file.path = root.join(&verilated_cpp_file.path);
                verilated_cpp_file.write()?;
            }
        }

        #[cfg(feature = "verilator")]
        {
            use verilator::gen::{Standard, Verilator};
            // let out_dir = std::env::var("OUT_DIR").unwrap();
            // let out_dir = PathBuf::from(out_dir);
            // std::fs::create_dir_all(&out_dir);
            let verilog_file = result.synthesized_file_path().to_string_lossy().to_string();
            let cpp_file = result
                .verilated_cpp_file_path()
                .to_string_lossy()
                .to_string();

            println!("cargo:rerun-if-changed={}", verilog_file);

            // Generate CPP from Verilog
            let mut verilator = Verilator::default();
            verilator
                .with_coverage(false)
                .with_trace(true)
                .no_warn("width")
                .no_warn("pinmissing")
                .no_warn("timescalemod")
                .with_performance_optimizations(true)
                .file_with_standard(
                    &root.join(result.verilog_file_path()),
                    Standard::Verilog2005,
                )
                .file(&root.join(cpp_file))
                .build(result.function_name());
        }
    }

    Ok(())
}
