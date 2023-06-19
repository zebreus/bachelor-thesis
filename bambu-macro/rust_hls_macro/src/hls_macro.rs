use std::collections::HashSet;

use proc_macro2::TokenStream;
use quote::quote;
use rust_hls_macro_lib::{
    make_content_compile, parse_hls_macro_args, parse_hls_macro_content, synthesized_module_name,
    synthesized_struct_name,
};

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
    // body.main_function_info.function_name
    let module_name = synthesized_module_name(&body.module.ident.to_string());
    let module_ident = quote::format_ident!("{}", module_name, span = body.module.ident.span());
    let struct_name = synthesized_struct_name(&body.main_function_info.function_name);
    let struct_ident = quote::format_ident!("{}", struct_name, span = body.module.ident.span());

    let module_visibility = body.module.vis.clone();

    let module = body.module;
    return Ok(quote!(
        #module

        #module_visibility mod #module_ident;
        #module_visibility use self :: #module_ident :: #struct_ident;
    ));
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
