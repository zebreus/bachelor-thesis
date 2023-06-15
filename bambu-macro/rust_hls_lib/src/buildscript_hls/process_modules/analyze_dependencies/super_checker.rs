use quote::ToTokens;

use super::{usetree_to_path, AnalyzeDependenciesError};

use syn::visit::{self, Visit};

// TODO: Implement a visitor that check that super does not leave the module
pub struct SuperChecker {
    errors: Vec<AnalyzeDependenciesError>,
    /// How deep the visitor is in the syntax tree
    depth: usize,
}

impl SuperChecker {
    pub fn new() -> Self {
        Self {
            errors: Vec::new(),
            depth: 0,
        }
    }
    pub fn get_result(&self) -> Result<(), AnalyzeDependenciesError> {
        let first_error = self.errors.first();
        match first_error {
            Some(error) => Err(error.to_owned()),
            None => Ok(()),
        }
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

        let current_path_string = path.to_owned().into_token_stream().to_string();

        if supers > self.depth {
            self.errors
                .push(AnalyzeDependenciesError::CannotSuperOutsideHlsModule {
                    path: current_path_string,
                });
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

        let mut super_checker = SuperChecker::new();
        super_checker.visit_file(&module);

        assert!(super_checker.get_result().is_err());
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

        let mut super_checker = SuperChecker::new();
        super_checker.visit_file(&module);

        assert!(super_checker.get_result().is_err());
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

        let mut super_checker = SuperChecker::new();
        super_checker.visit_file(&module);

        super_checker.get_result().unwrap();
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

        let mut super_checker = SuperChecker::new();
        super_checker.visit_file(&module);

        assert!(super_checker.get_result().is_err());
    }
}
