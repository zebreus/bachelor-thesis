//! Provides a `#[hls]` macro that can be used to synthesize a function into a rust-hdl module
//!
//! Documentation and examples can be found in the main crate [rust_hls](https://crates.io/crates/rust_hls)
#![feature(proc_macro_span)]

mod hls_macro;
use hls_macro::hls_macro;

/// Synthesizes a verilog module into a rust-hdl module.
///
/// ## Example
///
#[proc_macro_attribute]
pub fn hls(
    args: proc_macro::TokenStream,
    input: proc_macro::TokenStream,
) -> proc_macro::TokenStream {
    return hls_macro(args, input);
}
