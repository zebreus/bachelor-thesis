use darling::ast::NestedMeta;
use darling::{Error, FromMeta};
use proc_macro2::TokenStream;
use syn::LitStr;

#[derive(Debug, FromMeta, Default, Clone, PartialEq, Eq, Hash)]
pub struct HlsMacroArguments {
    #[darling(default)]

    /// These flags will be passed to the HLS compiler
    pub hls_flags: Option<LitStr>,
    /// These flags will be passed to the Rust compiler
    pub rust_flags: Option<LitStr>,
}

/// Parse the macro arguments.
///
/// the input is a tokenstream of whats inside the brackets of the macro call.
/// i.e.: `rust_flags = "smth", hls_flags = "smth"`
pub fn parse_hls_macro_args(args: TokenStream) -> Result<HlsMacroArguments, darling::Error> {
    let attr_args = match NestedMeta::parse_meta_list(args) {
        Ok(v) => v,
        Err(e) => {
            return Err(Error::from(e));
        }
    };

    let arguments = match HlsMacroArguments::from_list(&attr_args) {
        Ok(v) => v,
        Err(e) => {
            return Err(e);
        }
    };

    return Ok(arguments);
}
