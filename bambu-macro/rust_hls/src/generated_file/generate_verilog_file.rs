use std::path::PathBuf;

use crate::rust_hls::CrateFile;

use super::generate_output_module_path;

pub fn generate_verilog_output_filename(source_module_path: &Vec<String>) -> PathBuf {
    let synthesized_module_path = generate_output_module_path(source_module_path);
    let file_path = format!("rust_hls/verilog/{}.v", synthesized_module_path.join("/"));
    return PathBuf::from(file_path);
}

pub fn generate_verilog_file(source_module_path: &Vec<String>, verilog: String) -> CrateFile {
    let file_name = generate_verilog_output_filename(&source_module_path);
    let content = verilog;
    return CrateFile {
        path: file_name,
        content,
    };
}
