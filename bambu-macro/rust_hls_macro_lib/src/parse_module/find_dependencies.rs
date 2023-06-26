use std::collections::HashSet;

use syn::{spanned::Spanned, visit::Visit};

use super::super_checker::usetree_to_path;

// TODO: Implement a visitor that check that super does not leave the module
pub struct DependencyFinder {
    unused_dependencies: HashSet<String>,
    used_dependencies: HashSet<String>,
    errors: darling::error::Accumulator,
}

impl DependencyFinder {
    pub fn new(dependencies: &HashSet<String>) -> Self {
        Self {
            unused_dependencies: dependencies.clone(),
            used_dependencies: HashSet::new(),
            errors: darling::Error::accumulator(),
        }
    }
    pub fn finish(self) -> Result<HashSet<String>, darling::Error> {
        self.errors.finish_with(self.used_dependencies)
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
            self.errors.push(
                darling::Error::custom("Cannot reference crate root").with_span(&path.span()),
            );
            return;
        }

        let found_dependency = self
            .unused_dependencies
            .iter()
            .find(|dep| &dep.replace("-", "_") == &first_segment_ident)
            .cloned();

        if let Some(found_dependency) = found_dependency {
            self.unused_dependencies.remove(&found_dependency);
            self.used_dependencies.insert(found_dependency);
        }
    }
    fn visit_use_tree(&mut self, usetree: &'ast syn::UseTree) {
        let paths = usetree_to_path(usetree);
        for path in paths {
            self.visit_path(&path);
        }
    }
}

pub fn find_dependencies(
    content: &Vec<syn::Item>,
    available_dependencies: &HashSet<String>,
) -> Result<HashSet<String>, darling::Error> {
    let mut dependency_finder = DependencyFinder::new(available_dependencies);
    for item in content {
        dependency_finder.visit_item(item);
    }
    dependency_finder.finish()
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

        let mut available_dependencies = HashSet::new();
        available_dependencies.insert("std".into());

        let result = find_dependencies(&module.items, &available_dependencies).unwrap();
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

        let result = find_dependencies(&module.items, &available_deps).unwrap();
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

        let result = find_dependencies(&module.items, &available_deps).unwrap();
        assert_eq!(result.len(), 1);
    }

    #[test]
    fn dependency_checker_finds_hyphenated_dependency() {
        // The test file should contain a lot of modules. At least three
        let module: File = syn::parse2(::quote::quote! {
            use cool_package::max;

            pub fn add(left: usize, right: usize) -> usize {
                let x = max(left, right);
            }
        })
        .unwrap();

        let mut available_deps = HashSet::new();
        available_deps.insert("cool-package".into());

        let result = find_dependencies(&module.items, &available_deps).unwrap();
        assert_eq!(result.len(), 1);
    }
}
