use std::collections::HashSet;

use proc_macro2::TokenStream;
use quote::quote;
use rust_hls_macro_lib::{make_content_compile, parse_hls_macro_args, parse_hls_macro_content};

pub fn hls_wrapped(
    args: proc_macro2::TokenStream,
    input: proc_macro2::TokenStream,
) -> Result<proc_macro2::TokenStream, darling::Error> {
    let arguments = parse_hls_macro_args(args);
    let body = parse_hls_macro_content(input, &HashSet::new());

    let (_arguments, body) = match (arguments, body) {
        (Ok(args), Ok(body)) => (args, body),
        (Err(error), Ok(_)) | (Ok(_), Err(error)) => {
            return Err(error);
        }
        (Err(e1), Err(e2)) => {
            return Err(darling::Error::multiple(vec![e1, e2]));
        }
    };

    let module = body.module;
    return Ok(quote!(#module));

    // todo!()
    // let attr_args = match NestedMeta::parse_meta_list(args.into()) {
    //     Ok(v) => v,
    //     Err(e) => {
    //         return TokenStream::from(Error::from(e).write_errors());
    //     }
    // };
    // let _input = syn::parse_macro_input!(input as ItemFn);

    // let _args = match HlsMacroArguments::from_list(&attr_args) {
    //     Ok(v) => v,
    //     Err(e) => {
    //         return TokenStream::from(e.write_errors());
    //     }
    // };
    // let args = syn::parse::<HlsMacroArguments>(args)?;
    // // Err(syn::Error::new(
    // //     proc_macro::Span::call_site().into(),
    // //     format!("error creating a rust-hls instance: {}", error.to_string()),
    // // ))

    // let input_fn = syn::parse::<ItemFn>(input.clone())?;

    // // let location = locate_macro_call(input.clone()).or_else(|error| {
    // //     Err(syn::Error::new(
    // //         proc_macro::Span::call_site().into(),
    // //         format!("error locating macro call: {}", error.to_string()),
    // //     ))
    // // })?;

    // // let function_name = input_fn.sig.ident.to_string();
}

pub fn hls_macro(
    args: proc_macro::TokenStream,
    input: proc_macro::TokenStream,
) -> proc_macro::TokenStream {
    let args2: proc_macro2::TokenStream = args.into();
    let input2: proc_macro2::TokenStream = input.into();

    let result = hls_wrapped(args2.clone(), input2.clone());

    match result {
        Ok(stream) => quote!(#stream).into(),
        Err(error) => {
            let fixed_input = make_content_compile(input2);

            let compile_error = TokenStream::from(error.write_errors());

            quote!(
                #fixed_input

                #compile_error
            )
            .into()
        }
    }
}
