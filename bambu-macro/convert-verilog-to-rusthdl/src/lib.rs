//! # generate_rust_hdl_module
//! Automatically generate the rust-hdl module from a verilog module
//!
//! You can use `generate_rust_hdl_module` to generate a struct that represents a rust-hdl module from a verilog module.

mod extract_module_interface;
mod generate_rust_hdl_module;
mod verilog_parser;

pub use generate_rust_hdl_module::{generate_rust_hdl_module, RustHdlModule, Signal, SignalType};
