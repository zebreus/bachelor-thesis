use syn::visit::Visit;
use thiserror::Error;

use crate::buildscript_hls::find_modules::parse_rust_hls_macro;

#[derive(Error, Debug, Clone)]
pub enum RemoveHlsMacrosError {
    #[error("Nested rust_hls macros are not possible")]
    CannotUseHlsMacroInsideHlsModules,
}

// TODO: Implement a visitor that check that super does not leave the module
pub struct RemoveHlsMacrosVisitor {
    errors: Vec<RemoveHlsMacrosError>,
}

impl RemoveHlsMacrosVisitor {
    pub fn new() -> Self {
        Self { errors: Vec::new() }
    }
    pub fn get_result(&self) -> Result<(), RemoveHlsMacrosError> {
        let first_error = self.errors.first();
        match first_error {
            Some(error) => Err(error.clone()),
            None => Ok(()),
        }
    }
}

impl<'ast> Visit<'ast> for RemoveHlsMacrosVisitor {
    fn visit_attribute(&mut self, attribute: &'ast syn::Attribute) {
        if parse_rust_hls_macro(attribute)
            .or(Err(()))
            .and_then(|r| match r {
                Some(_) => Err(()),
                None => Ok(()),
            })
            .is_err()
        {
            self.errors
                .push(RemoveHlsMacrosError::CannotUseHlsMacroInsideHlsModules);
            return;
        }
        return;
    }
}

/// Removes hls macros from the file.
///
/// This function also assures that there are no superfluous hls macros
pub fn remove_hls_macros(content: &mut syn::File) -> Result<(), RemoveHlsMacrosError> {
    let items = &mut content.items;

    for item in items {
        let  syn::Item::Fn(item_fn) = item else {continue};

        let vec = &mut item_fn.attrs;

        let mut i = 0;
        while i < vec.len() {
            if parse_rust_hls_macro(&mut vec[i])
                .or(Err(()))
                .and_then(|r| match r {
                    Some(_) => Err(()),
                    None => Ok(()),
                })
                .is_err()
            {
                vec.remove(i);
            } else {
                i += 1;
            }
        }
    }

    let mut visitor = RemoveHlsMacrosVisitor::new();
    syn::visit::visit_file(&mut visitor, content);
    visitor.get_result()?;

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::remove_hls_macros;

    #[test]
    fn removes_hls_macro_at_functions() {
        // The test file should contain a lot of modules. At least three
        let mut with_no_mangle: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        remove_hls_macros(&mut with_no_mangle).unwrap();
        assert!(!prettyplease::unparse(&with_no_mangle).contains("#[hls]"));
    }

    #[test]
    fn removes_hls_macro_keeps_other_macros_intact() {
        // The test file should contain a lot of modules. At least three
        let mut with_no_mangle: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        remove_hls_macros(&mut with_no_mangle).unwrap();
        assert!(prettyplease::unparse(&with_no_mangle).contains("#[no_mangle]"));
    }

    #[test]
    fn detects_nested_hls_macro() {
        // The test file should contain a lot of modules. At least three
        let mut with_no_mangle: syn::File = syn::parse2(::quote::quote! {
            #[no_mangle]
            #[hls]
            pub extern fn add(left: usize, right: usize) -> usize {
                left + right
            }

            #[hls]
            mod nested {
                #[no_mangle]
                #[hls]
                pub extern fn add(left: usize, right: usize) -> usize {
                    left + right
                }
            }
        })
        .unwrap();

        remove_hls_macros(&mut with_no_mangle)
            .expect_err("Should fail because of nested hls macros");
    }
}
