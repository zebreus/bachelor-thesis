use super::FindFunctionNameError;

/// Assert that the function has the no_mangle attribute
pub fn assert_function_is_nomangle(function: &syn::ItemFn) -> Result<(), FindFunctionNameError> {
    let attributes = &function.attrs;
    let nomangle: Vec<_> = attributes
        .iter()
        .filter(|attribute| {
            let meta = &attribute.meta;
            let syn::Meta::Path(path) = meta else {
            return false;
        };
            let segments = &path.segments;
            if segments.len() != 1 {
                return false;
            }
            let Some(first_segment) = segments.first() else {
            return false;
        };
            let ident = &first_segment.ident.to_string();
            if ident != "no_mangle" {
                return false;
            }
            return true;
        })
        .collect();
    if nomangle.len() == 0 {
        return Err(FindFunctionNameError::NoMangleMissingOnHlsMainFunction);
    }
    return Ok(());
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn asserting_nomangle_detects_present_no_mangle() {
        // The test file should contain a lot of modules. At least three
        let with_no_mangle: syn::ItemFn = syn::parse2(::quote::quote! {
            #[no_mangle]
            pub fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        assert_function_is_nomangle(&with_no_mangle).unwrap();
    }

    #[test]
    fn asserting_nomangle_detects_missing_no_mangle() {
        // The test file should contain a lot of modules. At least three
        let without_no_mangle: syn::ItemFn = syn::parse2(::quote::quote! {
            pub fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        assert_function_is_nomangle(&without_no_mangle)
            .expect_err("Should have returned an error because no_mangle is missing");
    }
}
