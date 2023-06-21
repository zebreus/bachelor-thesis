//! A library containing support functions for [rust_hls](https://crates.io/crates/rust_hls) and [rust_hls_macro](https://crates.io/crates/rust_hls_macro)
//!
//! This basically contains all functions related to parsing the HLS macros from files. These functions are shared between the macro and the buildscript so they both parse in the same way and produce the same error messages.
//!
//! This crate uses darling::Error as its error type, because that supports bundling errors and span information.
mod generate_names;
mod hls_macro_helpers;
mod make_content_compile;
mod parse_arguments;
mod parse_content;
mod parse_module;

pub use generate_names::synthesized_module_name;
pub use generate_names::synthesized_struct_name;
pub use parse_content::parse_hls_macro_content;
pub use parse_module::check_nested_macros;
pub use parse_module::check_super;
pub use parse_module::find_dependencies;
pub use parse_module::find_main_function;
pub use parse_module::parse_hls_macro_module;
pub use parse_module::remove_hls_macros;
pub use parse_module::HlsFunctionInfo;
pub use parse_module::HlsModuleContentInformation;

pub use make_content_compile::make_content_compile;

pub use hls_macro_helpers::extract_hls_macro;
pub use hls_macro_helpers::is_rust_hls_macro;
pub use hls_macro_helpers::parse_hls_macro_attribute;
pub use parse_arguments::parse_hls_macro_args;
pub use parse_arguments::HlsArguments;
