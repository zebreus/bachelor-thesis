use syn::spanned::Spanned;

mod assert_function_is_extern;
use assert_function_is_extern::*;

use crate::{extract_hls_macro, HlsArguments};

/// Contains information about the HLS main function
#[derive(Debug, Clone, PartialEq, Eq, Hash, Default)]
pub struct HlsFunctionInfo {
    /// Name of the function
    pub function_name: String,
    /// Parameters of the function
    pub parameters: Vec<(String, syn::Type)>,
    /// Arguemtns of the function
    pub hls_arguments: HlsArguments,
}

/// Finds a HLS main function in the given content.
pub fn find_main_function(
    content: &Vec<syn::Item>,
    nothing_found_span: &proc_macro2::Span,
) -> Result<HlsFunctionInfo, darling::Error> {
    let mut errors = darling::Error::accumulator();

    let items = &content;
    let hls_functions: Vec<_> = items
        .iter()
        .filter_map(|item| match item {
            syn::Item::Fn(item_fn) => Some(item_fn),
            _ => None,
        })
        .filter_map(|function| {
            let attributes = &function.attrs;
            let hls_arguments = extract_hls_macro(attributes);
            let hls_arguments = errors.handle(hls_arguments).and_then(|f| f);
            let Some(hls_arguments) = hls_arguments else {
                return None;
            };
            return Some((function, hls_arguments));
        })
        .collect();

    let hls_function = hls_functions.into_iter().fold(
        Option::None,
        |first, (function, hls_arguments)| match first {
            Some(_) => {
                errors.push(
                    darling::Error::custom("Multiple hls functions")
                        .with_span(&function.sig.ident.span()),
                );
                first
            }
            None => Some((function, hls_arguments)),
        },
    );

    let Some((function, hls_arguments)) = hls_function else {
        errors.push(darling::Error::custom("No hls main function found")
        .with_span(nothing_found_span));
        // Default can never happen, but i dont know how to tell the compiler that
        return errors.finish_with(Default::default());
    };

    errors.handle_in(|| assert_function_is_extern(function));

    let function_name = function.sig.ident.to_string();

    let parameter_names = function
        .sig
        .inputs
        .iter()
        .filter_map(|input| {
            let syn::FnArg::Typed(input) = input else {
                errors.push(darling::Error::custom("HLS main function can not use self parameter").with_span(&input.span()));
                return None;
            };

            let syn::Pat::Ident(syn::PatIdent{ident,..}) = &input.pat.as_ref() else {
                errors.push(darling::Error::custom("The HLS main function must only use ident parameters. Idk how this error can occur.").with_span(&input.span()));
                return None;
            };

            let parameter_name = ident.to_string();
            let ty = input.ty.as_ref().clone();

            Some((parameter_name, ty))
        })
        .collect::<Vec<_>>();

    let function_info = HlsFunctionInfo {
        function_name,
        parameters: parameter_names,
        hls_arguments,
    };

    return errors.finish_with(function_info);
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn valid_functions_get_found() {
        // The test file should contain a lot of modules. At least three
        let content: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        let info = find_main_function(&content.items, &content.span()).unwrap();
        assert_eq!(info.function_name, "add");
    }

    #[test]
    fn fails_on_multiple_hls_functions() {
        // The test file should contain a lot of modules. At least three
        let content: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }

            #[no_mangle]
            #[hls]
            pub extern fn subtract(left: usize, right: usize) -> usize {
                left - right
            }
        })
        .unwrap();

        find_main_function(&content.items, &content.span())
            .expect_err("Should return an error that multiple hls functions were found");
    }

    #[test]
    fn fails_on_missing_hls_function() {
        // The test file should contain a lot of modules. At least three
        let content: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        find_main_function(&content.items, &content.span())
            .expect_err("Should return an error that no hls function was found");
    }

    #[test]
    fn fails_on_hls_function_without_extern() {
        // The test file should contain a lot of modules. At least three
        let content: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        find_main_function(&content.items, &content.span())
            .expect_err("Should return an error that extern is missing");
    }

    #[test]
    fn allows_hls_function_without_no_mangle() {
        // The test file should contain a lot of modules. At least three
        let content: syn::File = syn::parse2(::quote::quote! {
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        find_main_function(&content.items, &content.span()).unwrap();
    }
}
