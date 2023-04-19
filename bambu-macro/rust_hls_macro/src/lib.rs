//! Provides a [`hls!`] macro that can be used to synthesize a function into a rust-hdl module

use std::collections::HashMap;

use proc_macro2::{Ident, TokenStream};
use proc_macro_error::proc_macro_error;
use quote::quote;
use syn::{spanned::Spanned, ItemFn, LitStr, Token};

struct MacroAttributeThing {
    name: Ident,
    value: LitStr,
    equal: proc_macro2::Punct,
}

impl syn::parse::Parse for MacroAttributeThing {
    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
        let name = input.parse::<Ident>()?;
        let equal = input.parse::<proc_macro2::Punct>()?;
        let value = input.parse::<LitStr>()?;
        Ok(MacroAttributeThing { name, value, equal })
    }
}

impl quote::ToTokens for MacroAttributeThing {
    fn to_tokens(&self, tokens: &mut proc_macro2::TokenStream) {
        let name = &self.name;
        let equal = &self.equal;
        let value = &self.value;
        tokens.extend(quote!(#name #equal #value));
    }
}

struct HlsArguments {
    #[allow(dead_code)]
    hls_flags: Option<LitStr>,
    #[allow(dead_code)]
    rust_flags: Option<LitStr>,
}

impl syn::parse::Parse for HlsArguments {
    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
        let args = input.parse_terminated(MacroAttributeThing::parse, Token![,])?;
        let mut args_map: HashMap<_, _> = args
            .into_iter()
            .map(|arg| (arg.name.to_string(), arg))
            .collect();

        let build_arg = args_map.remove("rust_flags");
        let hls_arg = args_map.remove("hls_flags");

        let errors = args_map
            .into_iter()
            .map(|(_, arg)| {
                let name = arg.name.to_string();
                syn::Error::new(arg.span(), format!("unexpected argument {}", name))
            })
            .reduce(|mut previous, current| {
                previous.combine(current);
                previous
            });

        if let Some(errors) = errors {
            return Err(errors);
        }

        Ok(HlsArguments {
            hls_flags: hls_arg.map(|arg| arg.value),
            rust_flags: build_arg.map(|arg| arg.value),
        })
    }
}

fn hls_wrapped(
    args: proc_macro::TokenStream,
    input: proc_macro::TokenStream,
) -> Result<proc_macro::TokenStream, syn::Error> {
    let _args = syn::parse::<HlsArguments>(args)?;
    let input = syn::parse::<ItemFn>(input)?;

    Ok(quote!(#input).into())
}

/// Synthesizes a verilog module into a rust-hdl module.
///
/// ## Example
///
#[proc_macro_attribute]
#[proc_macro_error]
pub fn hls(
    args: proc_macro::TokenStream,
    input: proc_macro::TokenStream,
) -> proc_macro::TokenStream {
    let result = hls_wrapped(args, input.clone());

    match result {
        Ok(stream) => stream,
        Err(error) => {
            let compile_error = error.into_compile_error();
            // compile_error.into()
            let original_stream: TokenStream = input.into();
            quote!(
                #compile_error
                #original_stream
            )
            .into()
        }
    }
}
