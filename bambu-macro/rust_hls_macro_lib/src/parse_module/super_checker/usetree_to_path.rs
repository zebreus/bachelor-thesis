use syn::punctuated::Punctuated;
use syn::spanned::Spanned;

use syn::{Token, UseTree};

fn visit_use_tree(mut current: syn::Path, usetree: &syn::UseTree) -> Vec<syn::Path> {
    match usetree {
        UseTree::Path(path) => {
            current.segments.push_value(syn::PathSegment {
                ident: path.ident.clone(),
                arguments: syn::PathArguments::None,
            });
            current
                .segments
                .push_punct(Token![::](path.colon2_token.span()));

            return visit_use_tree(current, &path.tree);
        }
        UseTree::Name(name) => {
            current.segments.push_value(syn::PathSegment {
                ident: name.ident.clone(),
                arguments: syn::PathArguments::None,
            });
            return vec![current];
        }
        UseTree::Rename(rename) => {
            current.segments.push_value(syn::PathSegment {
                ident: rename.ident.clone(),
                arguments: syn::PathArguments::None,
            });
            return vec![current];
        }
        UseTree::Glob(glob) => {
            current.segments.push_value(syn::PathSegment {
                ident: syn::Ident::new("__star_token__", glob.star_token.span()),
                arguments: syn::PathArguments::None,
            });
            return vec![current];
        }
        UseTree::Group(group) => {
            let mut group_paths = Vec::new();

            for tree in &group.items {
                let paths = visit_use_tree(current.clone(), tree);
                group_paths.extend(paths.into_iter());
            }

            return group_paths;
        }
    }
}

pub fn usetree_to_path(tree: &syn::UseTree) -> Vec<syn::Path> {
    let empty_path = syn::Path {
        leading_colon: None,
        segments: Punctuated::new(),
    };
    let paths = visit_use_tree(empty_path, tree);
    return paths;
}

#[cfg(test)]
mod tests {
    use quote::ToTokens;

    use super::*;

    #[test]
    fn usetree_to_path_works() {
        // The test file should contain a lot of modules. At least three
        let module: syn::UseTree = syn::parse2(::quote::quote! {
            super::something
        })
        .unwrap();

        let paths = usetree_to_path(&module);
        assert_eq!(paths.len(), 1);
        let first_path = paths.first().unwrap();
        assert_eq!(
            first_path.into_token_stream().to_string(),
            "super :: something"
        );
    }

    #[test]
    fn usetree_to_path_with_groups() {
        // The test file should contain a lot of modules. At least three
        let module: syn::UseTree = syn::parse2(::quote::quote! {
            super::{something, other}
        })
        .unwrap();

        let paths = usetree_to_path(&module);
        assert_eq!(paths.len(), 2);
        let first_path = paths.first().unwrap();
        assert_eq!(
            first_path.into_token_stream().to_string(),
            "super :: something"
        );
        let second_path = paths.get(1).unwrap();
        assert_eq!(
            second_path.into_token_stream().to_string(),
            "super :: other"
        );
    }
}
