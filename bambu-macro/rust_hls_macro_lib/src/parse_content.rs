use darling::Error;
use proc_macro2::TokenStream;
use std::collections::HashSet;

use crate::{parse_hls_macro_module, HlsModuleContentInformation};

/// Parse the macro arguments.
///
/// the input is a tokenstream of whats inside the brackets of the macro call.
/// i.e.: `rust_flags = "smth", hls_flags = "smth"`
pub fn parse_hls_macro_content(
    content: TokenStream,
    available_dependencies: &HashSet<String>,
) -> Result<HlsModuleContentInformation, darling::Error> {
    let item: syn::Item = match syn::parse2(content) {
        Ok(item) => item,
        Err(e) => {
            return Err(Error::from(e));
        }
    };

    let result = match item {
        syn::Item::Mod(item_mod) => {
            let content = parse_hls_macro_module(item_mod, available_dependencies);
            content.and_then(|hls_module| Ok(hls_module))
        }
        _ => Err(Error::custom("The hls macro can only be used on modules")),
    };

    result
}
