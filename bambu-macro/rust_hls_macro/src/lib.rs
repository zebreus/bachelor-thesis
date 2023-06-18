//! Provides a [`hls!`] macro that can be used to synthesize a function into a rust-hdl module
//!
//! This is crate is highly experimental.
//!
//! It requires some things to work properly:
//! * The function must be public
//! * The function must be #[no_mangle]
//! * All imported things of the function should be fully qualified
//! * The function should not import things from its own crate. Other crates are fine
//! * Your crate needs to have `rust-hdl` and `wrap-verilog-in-rust-hdl-macro` as dependencies
//! * You need to have panda bambu installed and the binary as `bambu` in your path
//! * You should have bash installed
//! * Probably more things I did not think about

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
