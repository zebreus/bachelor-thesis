/// Functions for generating and parsing output files
use crate::rust_hls::CrateFile;
use std::path::PathBuf;

use regex::Regex;
use thiserror::Error;

mod filename_to_module_path;
mod generate_rust_hdl_struct;
pub use filename_to_module_path::*;
pub use generate_rust_hdl_struct::*;
// mod generate_verilator_rust_hdl_struct;

/// Generate the name of the generated file from the rust module path of the input file.
///
/// Relative to the crate root
pub fn generate_output_filename(source_module_path: &Vec<String>) -> PathBuf {
    module_path_to_filename(&generate_output_module_path(source_module_path))
}

/// Generate the module path to the generated file
pub fn generate_output_module_path(source_module_path: &Vec<String>) -> Vec<String> {
    let mut synthesized_module_path = source_module_path.clone();
    let last_module = synthesized_module_path.pop().unwrap_or("lib".into());
    synthesized_module_path.push(rust_hls_macro_lib::synthesized_module_name(&last_module));
    return synthesized_module_path;
}

fn generate_hash_comment(hash: &str) -> String {
    format!("// rust_hls hash: \"{}\"", hash)
}

fn generate_hash_regex() -> Regex {
    let regex = Regex::new(r#"(?m)^[\s]*// rust_hls hash: "([^"]*)"[\s]*$"#).unwrap();
    return regex;
}

#[cfg(feature = "verilator")]
type GenerateFileContentResult = (String, CrateFile);
#[cfg(not(feature = "verilator"))]
type GenerateFileContentResult = (String,);

/// Generates a output file from a verilog description
///
/// The hash is added to the file in a comment.
pub fn generate_file_content(
    verilog: &str,
    verilog_main_module: &str,
    struct_name: &str,
    hash: &str,
    parameter_names: &Vec<String>,
    source_module_path: &Vec<String>,
) -> Result<GenerateFileContentResult, GenerateRustHdlStructError> {
    // TODO: Dummy implementation
    let hash_comment = generate_hash_comment(hash);
    let rust_hdl_struct = generate_rust_hdl_struct(
        verilog,
        verilog_main_module,
        struct_name,
        parameter_names,
        source_module_path,
    )?;
    let result: String = format!(
        r##"// This file was generated by rust_hls. Please do not edit it manually.
{}

{}

#[allow(dead_code)]
const VERILOG: &str = r#"{}"#;"##,
        hash_comment,
        prettyplease::unparse(&rust_hdl_struct.rust_file),
        verilog
    )
    .into();
    #[cfg(feature = "verilator")]
    return Ok((result, rust_hdl_struct.cpp_shim));
    #[cfg(not(feature = "verilator"))]
    return Ok((result,));
}

// TODO: This is really hacky
#[cfg(feature = "verilator")]
type GenerateFileResult = (CrateFile, CrateFile);
#[cfg(not(feature = "verilator"))]
type GenerateFileResult = (CrateFile,);

/// Generates a output file from a verilog description
///
/// The hash is added to the file in a comment.
pub fn generate_file(
    source_module_path: &Vec<String>,
    verilog: &str,
    verilog_main_module: &str,
    struct_name: &str,
    hash: &str,
    parameter_names: &Vec<String>,
) -> Result<GenerateFileResult, GenerateRustHdlStructError> {
    let file_name = generate_output_filename(source_module_path);
    let content = generate_file_content(
        verilog,
        verilog_main_module,
        struct_name,
        hash,
        parameter_names,
        source_module_path,
    )?;
    #[cfg(feature = "verilator")]
    return Ok((
        CrateFile {
            path: file_name,
            content: content.0,
        },
        content.1,
    ));
    #[cfg(not(feature = "verilator"))]
    return Ok((CrateFile {
        path: file_name,
        content: content.0,
    },));
}

#[derive(Error, Debug)]
pub enum ExtractHashError {
    #[error(
        "Failed to find a rust_hls hash in an existing output file. Maybe it was modified by hand?"
    )]
    FailedToFindHashInExistingFile,
}

/// Extracts the file hash from a generated file
pub fn extract_file_hash(content: &str) -> Result<String, ExtractHashError> {
    let regex = generate_hash_regex();
    let captures = regex
        .captures(content)
        .ok_or(ExtractHashError::FailedToFindHashInExistingFile)?;
    let hash = captures
        .get(1)
        .ok_or(ExtractHashError::FailedToFindHashInExistingFile)?;
    return Ok(hash.as_str().to_string());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn generate_filename_seems_to_work() {
        let filename = generate_output_filename(&vec!["test".to_string(), "test2".to_string()]);
        assert!(filename.starts_with("src"));
        assert_eq!(filename.extension().unwrap(), "rs");
    }

    #[test]
    fn generate_module_path_seems_to_work() {
        let module_path =
            generate_output_module_path(&vec!["test".to_string(), "test2".to_string()]);
        assert_eq!(module_path.first().unwrap(), "test");
    }

    #[test]
    fn generate_content_seems_to_work() {
        let generated_file = generate_file_content(
            r#"
        module counter
        (
            input clock,
            output [5:0] led
        );
        
        reg [23:0] clockCounter = 0;
        localparam WAIT_TIME = 1000;
        reg [5:0] ledCounter = 0;
        
        always @(posedge clock) begin
            clockCounter <= clockCounter + 1;
            if (clockCounter == WAIT_TIME) begin
                clockCounter <= 0;
                ledCounter <= ledCounter + 1;
            end
        end
        
        assign led = ~ledCounter;
        endmodule
        "#,
            "counter",
            "Counter",
            "cool_hash",
            &vec![],
            &vec![],
        )
        .unwrap();

        assert!(generated_file.0.contains("struct Counter"));
        assert!(generated_file.0.contains("always @(posedge clock) begin"));
    }

    #[test]
    fn extract_and_generate_hash_work_together() {
        let original_hash = "sdfsadkfjsjdklf823rfew";
        let generated_hash_comment = generate_hash_comment(original_hash);

        assert!(generated_hash_comment.contains(original_hash));

        let extracted_hash = extract_file_hash(&generated_hash_comment).unwrap();

        assert_eq!(extracted_hash, original_hash);
    }

    #[test]
    fn extract_hash_regex_works() {
        let original_hash = "sdfsadkfjsjdklf823rfew";
        let generated_hash_comment = generate_hash_comment(original_hash);

        let file = format!(
            r##"
        stuff
        
{}

other stuff
        "##,
            generated_hash_comment
        );
        let extracted_hash = extract_file_hash(&file).unwrap();

        assert_eq!(extracted_hash, original_hash);
    }

    #[test]
    fn extract_hash_regex_works_with_leading_and_trailing_spaces() {
        let original_hash = "sdfsadkfjsjdklf823rfew";
        let generated_hash_comment = generate_hash_comment(original_hash);

        let file = format!(
            r##"
        stuff
        
     {}            

other stuff
        "##,
            generated_hash_comment
        );
        let extracted_hash = extract_file_hash(&file).unwrap();

        assert_eq!(extracted_hash, original_hash);
    }

    #[test]
    fn hash_can_be_extracted_from_generated_content() {
        let original_hash = "cool_hash";
        let generated_file = generate_file_content(
            r#"
        module counter
        (
            input clock,
            output [5:0] led
        );
        
        reg [23:0] clockCounter = 0;
        localparam WAIT_TIME = 1000;
        reg [5:0] ledCounter = 0;
        
        always @(posedge clock) begin
            clockCounter <= clockCounter + 1;
            if (clockCounter == WAIT_TIME) begin
                clockCounter <= 0;
                ledCounter <= ledCounter + 1;
            end
        end
        
        assign led = ~ledCounter;
        endmodule
        "#,
            "counter",
            "Counter",
            &original_hash,
            &vec![],
            &vec![],
        )
        .unwrap();

        let extracted_hash = extract_file_hash(&generated_file.0).unwrap();

        assert_eq!(extracted_hash, original_hash);
    }
}
