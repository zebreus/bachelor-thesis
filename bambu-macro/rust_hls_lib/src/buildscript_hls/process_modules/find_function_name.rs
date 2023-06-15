use thiserror::Error;

use super::super::find_modules::{extract_rust_hls_macro, HlsArguments, HlsMacroError};

mod assert_function_is_extern;
mod assert_function_is_nomangle;
use assert_function_is_extern::*;
use assert_function_is_nomangle::*;

#[derive(Error, Debug)]
pub enum FindFunctionNameError {
    #[error("Cannot find a hls function")]
    NoHlsMainFunction,
    #[error("Found multiple hls functions")]
    MoreThanOneHlsMainFunction,
    #[error("HLS main function needs to be #[no_mangle]")]
    NoMangleMissingOnHlsMainFunction,
    #[error("HLS main function needs to be extern")]
    ExternMissingOnHlsMainFunction,
    #[error(transparent)]
    HlsMacroError(#[from] HlsMacroError),
}

pub fn find_function_name(
    content: &syn::File,
) -> Result<(String, HlsArguments), FindFunctionNameError> {
    let items = &content.items;
    let hls_functions: Result<Vec<_>, _> = items
        .iter()
        .filter_map(|item| match item {
            syn::Item::Fn(item_fn) => Some(item_fn),
            _ => None,
        })
        .filter_map(|function| {
            let attributes = &function.attrs;
            let hls_arguments = extract_rust_hls_macro(attributes);
            let hls_arguments = match hls_arguments {
                Ok(hls_arguments) => hls_arguments,
                Err(error) => return Some(Err(error)),
            };
            let Some(hls_arguments) = hls_arguments else {
                return None;
            };
            return Some(Ok((function, hls_arguments)));
        })
        .collect();
    let hls_functions = hls_functions?;

    if hls_functions.len() > 1 {
        return Err(FindFunctionNameError::MoreThanOneHlsMainFunction);
    }
    let Some( (function, hls_arguments) ) = hls_functions.into_iter().nth(0) else {
        return Err(FindFunctionNameError::NoHlsMainFunction);
    };

    assert_function_is_extern(function)?;
    assert_function_is_nomangle(function)?;

    let function_name = &function.sig.ident.to_string();

    return Ok((function_name.clone(), hls_arguments));
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn valid_functions_get_found() {
        // The test file should contain a lot of modules. At least three
        let with_no_mangle: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        let function_name = find_function_name(&with_no_mangle).unwrap();
        assert_eq!(function_name.0, "add");
    }

    #[test]
    fn fails_on_multiple_hls_functions() {
        // The test file should contain a lot of modules. At least three
        let with_no_mangle: syn::File = syn::parse2(::quote::quote! {
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

        find_function_name(&with_no_mangle)
            .expect_err("Should return an error that multiple hls functions were found");
    }

    #[test]
    fn fails_on_missing_hls_function() {
        // The test file should contain a lot of modules. At least three
        let with_no_mangle: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        find_function_name(&with_no_mangle)
            .expect_err("Should return an error that no hls function was found");
    }

    #[test]
    fn fails_on_hls_function_without_extern() {
        // The test file should contain a lot of modules. At least three
        let with_no_mangle: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        find_function_name(&with_no_mangle)
            .expect_err("Should return an error that extern is missing");
    }

    #[test]
    fn fails_on_hls_function_without_no_mangle() {
        // The test file should contain a lot of modules. At least three
        let with_no_mangle: syn::File = syn::parse2(::quote::quote! {
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        find_function_name(&with_no_mangle)
            .expect_err("Should return an error that no_mangle is missing");
    }
}
