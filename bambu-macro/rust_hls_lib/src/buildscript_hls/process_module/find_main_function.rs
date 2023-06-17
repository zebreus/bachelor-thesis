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
    #[error("The HLS main function can not use self")]
    HlsMainFunctionHasSelfParameter,
    #[error("The HLS main function must only use ident parameters. Idk how this error can occur.")]
    HlsMainFunctionHasParameterWithoutIdentifier,
    #[error(transparent)]
    HlsMacroError(#[from] HlsMacroError),
}

/// Contains information about the HLS main function
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct HlsFunctionInfo {
    /// Name of the function
    pub function_name: String,
    /// Parameters of the function
    pub parameters: Vec<(String, syn::Type)>,
    /// Arguemtns of the function
    pub hls_arguments: HlsArguments,
}

pub fn find_main_function(content: &syn::File) -> Result<HlsFunctionInfo, FindFunctionNameError> {
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

    let function_name = function.sig.ident.to_string();

    let parameter_names = function
        .sig
        .inputs
        .iter()
        .map(|input| {
            let syn::FnArg::Typed(input) = input else {
                return Err(FindFunctionNameError::HlsMainFunctionHasSelfParameter);
            };

            let syn::Pat::Ident(syn::PatIdent{ident,..}) = &input.pat.as_ref() else {
                return Err(FindFunctionNameError::HlsMainFunctionHasParameterWithoutIdentifier);
            };

            let parameter_name = ident.to_string();
            let ty = input.ty.as_ref().clone();

            Ok((parameter_name, ty))
        })
        .collect::<Result<Vec<_>, _>>()?;

    let function_info = HlsFunctionInfo {
        function_name,
        parameters: parameter_names,
        hls_arguments,
    };

    return Ok(function_info);
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

        let info = find_main_function(&with_no_mangle).unwrap();
        assert_eq!(info.function_name, "add");
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

        find_main_function(&with_no_mangle)
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

        find_main_function(&with_no_mangle)
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

        find_main_function(&with_no_mangle)
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

        find_main_function(&with_no_mangle)
            .expect_err("Should return an error that no_mangle is missing");
    }
}
