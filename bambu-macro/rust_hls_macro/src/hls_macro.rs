#![feature(proc_macro_span)]

use std::collections::HashMap;

use locate_file::locate_macro_call;
use proc_macro2::{Ident, TokenStream};
use quote::quote;
use rust_hls_lib::{RustHls, RustHlsBuilder};
use syn::{spanned::Spanned, ItemFn, LitStr, Token, Visibility};

mod locate_file;

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

pub fn hls_wrapped(
    args: proc_macro::TokenStream,
    input: proc_macro::TokenStream,
) -> Result<proc_macro::TokenStream, syn::Error> {
    let _args = syn::parse::<HlsArguments>(args)?;
    let input = syn::parse::<ItemFn>(input)?;

    match input.vis {
        Visibility::Public(_) => {}
        _ => {
            return Err(syn::Error::new(
                input.vis.span(),
                "hls! macro can only be used on public functions",
            ))
        }
    }

    let location = locate_macro_call().or_else(|error| {
        Err(syn::Error::new(
            proc_macro::Span::call_site().into(),
            format!("error locating macro call: {}", error.to_string()),
        ))
    })?;

    let function_name = input.sig.ident.to_string();

    let mut rust_hls = RustHlsBuilder::default()
        .function_file(location.function_file)
        .crate_path(location.crate_directory)
        .function_name(function_name)
        .build()
        .or_else(|error| {
            Err(syn::Error::new(
                proc_macro::Span::call_site().into(),
                format!("error creating a rust-hls instance: {}", error.to_string()),
            ))
        })?;

    let verilog = rust_hls.do_everything().or_else(|error| {
        Err(syn::Error::new(
            proc_macro::Span::call_site().into(),
            format!("rust-hls error: {}", error.to_string()),
        ))
    })?;

    let verilog_literal = LitStr::new(&verilog, proc_macro::Span::call_site().into());

    Ok(quote!(
        #input

        const GENERATED: &str = #verilog_literal;
    )
    .into())
}

pub fn hls_macro(
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
