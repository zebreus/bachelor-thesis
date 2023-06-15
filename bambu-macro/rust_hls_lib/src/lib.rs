//! Functions for performing HLS from Rust
//!
//! This crate provides functions for performing HLS from Rust. It is intended to be used with the `rust_hls` crate which provides a macro using the functions in this crate.
//!
//! High-level synthesis is performed by ripping out a function an creating a new (temporary) crate that only exports that function.
//! A bash script containing the commands to synthesize the temporary crate is then created and executed.
//! The resulting Verilog is then returned as a string.

mod buildscript_hls;
mod cache_workspace;
mod caching;
mod extract_function_crate;
mod generate_hls_script;
mod rust_hls_old;
mod rust_hls_options;

pub use buildscript_hls::buildscript_hls;

pub use rust_hls_options::RustHls;
pub use rust_hls_options::RustHlsError;
pub use rust_hls_options::RustHlsResult;

pub use generate_hls_script::{DEFAULT_HLS_FLAGS, DEFAULT_RUST_FLAGS};
