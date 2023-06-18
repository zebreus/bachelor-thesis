use crate::is_rust_hls_macro;

/// Removes hls macros from all ItemFns in the list
pub fn remove_hls_macros(items: &mut Vec<syn::Item>) -> () {
    // Remove functions on which the macro is valid
    for item in items {
        let  syn::Item::Fn(item_fn) = item else {continue};

        // TODO: Use drain_filter once its stablized
        let vec = &mut item_fn.attrs;

        let mut i = 0;
        while i < vec.len() {
            if is_rust_hls_macro(&mut vec[i].path()) {
                vec.remove(i);
            } else {
                i += 1;
            }
        }
    }

    ()
}

#[cfg(test)]
mod tests {
    use super::remove_hls_macros;

    #[test]
    fn removes_hls_macro_at_functions() {
        // The test file should contain a lot of modules. At least three
        let mut content: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        remove_hls_macros(&mut content.items);
        assert!(!prettyplease::unparse(&content).contains("#[hls]"));
    }

    #[test]
    fn removes_hls_macro_keeps_other_macros_intact() {
        // The test file should contain a lot of modules. At least three
        let mut content: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        remove_hls_macros(&mut content.items);
        assert!(prettyplease::unparse(&content).contains("#[no_mangle]"));
    }

    #[test]
    fn keeps_hls_macros_on_nested_functions() {
        // The test file should contain a lot of modules. At least three
        let mut content: syn::File = syn::parse2(::quote::quote! {
            mod nested {
                #[no_mangle]
                #[hls]
                pub extern fn add(left: usize, right: usize) -> usize {
                    left + right
                }
            }
        })
        .unwrap();

        remove_hls_macros(&mut content.items);
        assert!(prettyplease::unparse(&content).contains("#[hls]"));
    }

    #[test]
    fn keeps_hls_macros_on_other_things() {
        // The test file should contain a lot of modules. At least three
        let mut content: syn::File = syn::parse2(::quote::quote! {
            #[hls]
            mod nested {
                #[no_mangle]
                pub extern fn add(left: usize, right: usize) -> usize {
                    left + right
                }
            }
        })
        .unwrap();

        remove_hls_macros(&mut content.items);
        assert!(prettyplease::unparse(&content).contains("#[hls]"));
    }
}
