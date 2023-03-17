//! # generate_rust_hdl_module
//! This crate provides a `extract_rust_hdl_interface` function that extracts all the info you need to generate a rust-hdl module from a Verilog module.
//!
//! The function does not actually generate code it just extracts the interface. It is mainly meant be used through the [`wrap_verilog!`](https://docs.rs/proc-macro-error/latest/wrap_verilog_in_rust_hdl_macro/) macro.
mod extract_rust_hdl_interface;
mod extract_verilog_interface;
mod verilog_parser;

pub use extract_rust_hdl_interface::{
    extract_rust_hdl_interface, RustHdlModule, Signal, SignalType,
};
pub use extract_verilog_interface::Direction;
