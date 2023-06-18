mod usetree_to_path;
pub use usetree_to_path::usetree_to_path;

use syn::{
    spanned::Spanned,
    visit::{self, Visit},
};

/// The super checker check that the super keyword is not used to leave the HLS module
pub struct SuperChecker {
    errors: darling::error::Accumulator,
    /// How deep the visitor is in the syntax tree
    depth: usize,
}

impl SuperChecker {
    pub fn new() -> Self {
        Self {
            errors: darling::Error::accumulator(),
            depth: 0,
        }
    }
    pub fn finish(self) -> Result<(), darling::Error> {
        self.errors.finish_with(())
    }
}

impl<'ast> Visit<'ast> for SuperChecker {
    fn visit_path(&mut self, path: &'ast syn::Path) {
        let supers = path
            .segments
            .iter()
            .fold((0usize, true), |(supers, leading), segment| {
                if segment.ident.to_string() == "super" && leading {
                    (supers + 1, true)
                } else {
                    (supers, false)
                }
            })
            .0;

        if supers > self.depth {
            self.errors.push(
                darling::Error::custom("super must not leave the HLS module")
                    .with_span(&path.span()),
            );
            return;
        }
        return;
    }
    fn visit_use_tree(&mut self, usetree: &'ast syn::UseTree) {
        let paths = usetree_to_path(usetree);
        for path in paths {
            self.visit_path(&path);
        }
    }
    fn visit_item_mod(&mut self, i: &'ast syn::ItemMod) {
        self.depth += 1;
        visit::visit_item_mod(self, i);
        self.depth -= 1;
    }
}

pub fn check_super(content: &Vec<syn::Item>) -> Result<(), darling::Error> {
    let mut super_checker = SuperChecker::new();
    for item in content {
        super_checker.visit_item(item);
    }
    super_checker.finish()
}

#[cfg(test)]
mod tests {
    use super::*;
    use syn::File;

    #[test]
    fn super_checker_finds_super_in_use() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            use super::something;

            pub fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        assert!(check_super(&module.items).is_err());
    }

    #[test]
    fn super_checker_finds_super_in_function() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            pub fn add(left: usize, right: usize) -> usize {
                super::something(left, right);
            }
        })
        .unwrap();

        assert!(check_super(&module.items).is_err());
    }

    #[test]
    fn super_checker_allows_single_super_in_submodule() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            mod cool_module {
                pub fn add(left: usize, right: usize) -> usize {
                    super::something(left, right);
                }
            }
        })
        .unwrap();

        check_super(&module.items).unwrap();
    }

    #[test]
    fn super_checker_finds_double_super_in_submodule() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            mod cool_module {
                pub fn add(left: usize, right: usize) -> usize {
                    super::super::something(left, right);
                }
            }
        })
        .unwrap();

        assert!(check_super(&module.items).is_err());
    }
}
