use syn::{spanned::Spanned, visit::Visit};

use crate::{extract_hls_macro, parse_hls_macro_attribute};

struct CheckNestedMacrosVisitor {
    errors: darling::error::Accumulator,
}

impl CheckNestedMacrosVisitor {
    fn new() -> Self {
        Self {
            errors: darling::Error::accumulator(),
        }
    }
    fn finish(self) -> Result<(), darling::Error> {
        self.errors.finish_with(())
    }
}

impl<'ast> Visit<'ast> for CheckNestedMacrosVisitor {
    fn visit_item_mod(&mut self, modules: &'ast syn::ItemMod) {
        let hls_macro = extract_hls_macro(&modules.attrs);
        let hls_macro = self.errors.handle(hls_macro).and_then(|f| f);

        match hls_macro {
            Some(_) => {
                self.errors.push(
                    darling::Error::custom("HLS modules must not be nested")
                        .with_span(&modules.ident.span()),
                );
            }
            None => {}
        }

        let Some(content) = &modules.content else {return};

        for item in &content.1 {
            syn::visit::visit_item(self, item);
        }
    }

    fn visit_attribute(&mut self, attribute: &'ast syn::Attribute) {
        match parse_hls_macro_attribute(attribute) {
            Ok(Some(_)) | Err(_) => {
                self.errors.push(
                    darling::Error::custom(
                        "HLS macro must only be applied to modules and the main function",
                    )
                    .with_span(&attribute.meta.path().span()),
                );
            }
            Ok(None) => {}
        }
    }
}

/// Verifies that all nested macros are correct.
///
/// This generates an error for everything with a #[hls] attribute in items.
pub fn check_nested_macros(content: &Vec<syn::Item>) -> Result<(), darling::Error> {
    let mut visitor = CheckNestedMacrosVisitor::new();
    for item in content {
        syn::visit::visit_item(&mut visitor, item);
    }
    visitor.finish()
}

#[cfg(test)]
mod tests {
    use super::check_nested_macros;

    #[test]
    fn detects_one_nested_hls_module() {
        let input: syn::File = syn::parse2(::quote::quote! {
            #[hls]
            mod nested {
            }
        })
        .unwrap();

        check_nested_macros(&input.items).expect_err("Should detect nested HLS module");
    }

    #[test]
    fn allows_nested_non_hls_module() {
        let input: syn::File = syn::parse2(::quote::quote! {
            mod nested_a {
                mod double_nested {
                }
            }
            mod nested_b {
            }
        })
        .unwrap();

        check_nested_macros(&input.items).unwrap();
    }

    #[test]
    fn detects_deeply_nested_hls_module() {
        let input: syn::File = syn::parse2(::quote::quote! {
            mod nested_b {
            }
            mod nested_a {
                mod double_nested {
                    #[hls]
                    mod hls_deep_nested {
                    }
                }
            }
        })
        .unwrap();

        check_nested_macros(&input.items).unwrap_err();
    }

    #[test]
    fn detects_nested_hls_macro_on_other_things() {
        let input: syn::File = syn::parse2(::quote::quote! {
            mod nested_a {
                mod double_nested {
                }
                #[hls]
                fn toast() {}
            }
            mod nested_b {
            }
        })
        .unwrap();

        check_nested_macros(&input.items).unwrap_err();
    }
}
