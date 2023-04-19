//! Provides a [`hls!`] macro that can be used to synthesize a function into a rust-hdl module

use proc_macro_error::proc_macro_error;
use quote::quote;

/// Synthesizes a verilog module into a rust-hdl module.
///
/// ## Example
///
#[proc_macro_error]
#[proc_macro]
pub fn wrap_verilog(_input: proc_macro::TokenStream) -> proc_macro::TokenStream {
    return quote!().into();
}
