use std::collections::HashSet;

use quote::ToTokens;

use syn::visit::Visit;

use super::{usetree_to_path, AnalyzeDependenciesError};
// TODO: Implement a visitor that check that super does not leave the module

pub struct DependencyFinder {
    unused_dependencies: HashSet<String>,
    used_dependencies: HashSet<String>,
    errors: Vec<AnalyzeDependenciesError>,
}

impl DependencyFinder {
    pub fn new(dependencies: &HashSet<String>) -> Self {
        Self {
            unused_dependencies: dependencies.clone(),
            used_dependencies: HashSet::new(),
            errors: Vec::new(),
        }
    }
    pub fn get_result(&self) -> Result<HashSet<String>, AnalyzeDependenciesError> {
        let first_error = self.errors.first();
        match first_error {
            Some(error) => Err(error.to_owned()),
            None => Ok(self.used_dependencies.clone()),
        }
    }
}

// `crate::` Root of this crate
// `self::` Root of the current module
// `super::` Root of the parent of the current module
// self and super can only be used in start position
// `self::super` is legal
// `::` Root of the crate tree. Can be used for external crates like `::glob::glob`. Does not contain the current crate
impl<'ast> Visit<'ast> for DependencyFinder {
    fn visit_path(&mut self, path: &'ast syn::Path) {
        let Some(first_segment) = path.segments.first() else {
            // Path has no segments. Maybe :: is valid?
            return;
        };
        let first_segment_ident = first_segment.ident.to_string();

        if first_segment_ident == "crate" {
            self.errors
                .push(AnalyzeDependenciesError::CannotReferenceCrateRoot {
                    path: path.to_owned().into_token_stream().to_string(),
                });
            return;
        }

        if self.unused_dependencies.contains(&first_segment_ident) {
            self.unused_dependencies.remove(&first_segment_ident);
            self.used_dependencies.insert(first_segment_ident);
        }
    }
    fn visit_use_tree(&mut self, usetree: &'ast syn::UseTree) {
        let paths = usetree_to_path(usetree);
        for path in paths {
            self.visit_path(&path);
        }
    }
}

#[cfg(test)]
mod tests {

    use super::*;
    use syn::File;

    #[test]
    fn dependency_checker_does_not_find_dependencies_if_there_are_none() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            #[hls]
            #[no_mangle]
            pub fn add(left: usize, right: usize) -> usize {
                left + right
            }
        })
        .unwrap();

        let mut available_deps = HashSet::new();
        available_deps.insert("std".into());
        let mut visitor = DependencyFinder::new(&available_deps);
        visitor.visit_file(&module);

        let result = visitor.get_result().unwrap();
        assert_eq!(result.len(), 0);
    }

    #[test]
    fn dependency_checker_finds_used_dependencies() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            #[hls]
            #[no_mangle]
            pub fn add(left: usize, right: usize) -> usize {
                let x = std::cmp::max(left, right);
            }
        })
        .unwrap();

        let mut available_deps = HashSet::new();
        available_deps.insert("std".into());
        let mut visitor = DependencyFinder::new(&available_deps);
        visitor.visit_file(&module);

        visitor.get_result().unwrap();

        let result = visitor.get_result().unwrap();
        assert_eq!(result.len(), 1);
    }

    #[test]
    fn dependency_checker_finds_used_dependencies_in_use() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            use std::cmp::max;

            pub fn add(left: usize, right: usize) -> usize {
                let x = max(left, right);
            }
        })
        .unwrap();

        let mut available_deps = HashSet::new();
        available_deps.insert("std".into());
        let mut visitor = DependencyFinder::new(&available_deps);
        visitor.visit_file(&module);

        visitor.get_result().unwrap();

        let result = visitor.get_result().unwrap();
        assert_eq!(result.len(), 1);
    }
}
