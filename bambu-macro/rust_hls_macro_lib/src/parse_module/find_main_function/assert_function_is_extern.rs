/// Assert that the function has the extern keyword
pub fn assert_function_is_extern(function: &syn::ItemFn) -> Result<(), darling::Error> {
    let Some(abi) = &function.sig.abi else {
        return Err(darling::Error::custom("HLS main functions must be extern \"C\"").with_span(&function.sig.ident.span()));
    };
    let Some(extern_string) = &abi.name else {
        // extern without name is the same as extern "C"
        return Ok(());
    };
    if extern_string.value() == "C" {
        return Ok(());
    }
    return Err(
        darling::Error::custom("HLS main functions must be extern \"C\"")
            .with_span(&function.sig.ident.span()),
    );
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn asserting_extern_detects_present_extern() {
        // The test file should contain a lot of modules. At least three
        let with_extern: syn::ItemFn = syn::parse2(::quote::quote! {
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        assert_function_is_extern(&with_extern).unwrap();
    }

    #[test]
    fn asserting_extern_detects_present_extern_c() {
        // The test file should contain a lot of modules. At least three
        let with_extern_c: syn::ItemFn = syn::parse2(::quote::quote! {
            pub extern "C" fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        assert_function_is_extern(&with_extern_c).unwrap();
    }

    #[test]
    fn asserting_extern_detects_missing_extern() {
        // The test file should contain a lot of modules. At least three
        let without_extern: syn::ItemFn = syn::parse2(::quote::quote! {
            pub fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        assert_function_is_extern(&without_extern)
            .expect_err("Should have returned an error because no_mangle is missing");
    }
}
