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
#[cfg(feature = "perform-hls")]
mod hls_macro;
#[cfg(feature = "perform-hls")]
use hls_macro::hls_macro;

#[cfg(not(feature = "perform-hls"))]
mod dummy_macro;
#[cfg(not(feature = "perform-hls"))]
use dummy_macro::dummy_macro;

/// Synthesizes a verilog module into a rust-hdl module.
///
/// ## Example
///
#[proc_macro_attribute]
pub fn hls(
    args: proc_macro::TokenStream,
    input: proc_macro::TokenStream,
) -> proc_macro::TokenStream {
    #[cfg(feature = "perform-hls")]
    return hls_macro(args, input);

    #[cfg(not(feature = "perform-hls"))]
    return dummy_macro(args, input);
}
