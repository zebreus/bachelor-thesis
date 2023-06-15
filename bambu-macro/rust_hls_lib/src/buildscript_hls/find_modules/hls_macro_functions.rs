pub use hls_macro_arguments::HlsArguments;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum HlsMacroError {
    #[error("Failed to parse macro arguments: {message}")]
    FailedToParseMacroArguments { message: String },
    #[error("You can only have a single hls macro on one thing.")]
    MultipleRustHlsMacros {},
}

mod hls_macro_arguments {
    use std::collections::HashMap;

    use proc_macro2::Ident;
    use quote::quote;
    use syn::{spanned::Spanned, LitStr, Token};

    pub struct MacroAttributeThing {
        pub name: Ident,
        pub value: LitStr,
        pub equal: proc_macro2::Punct,
    }

    impl syn::parse::Parse for MacroAttributeThing {
        fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
            let name = input.parse::<Ident>()?;
            let equal = input.parse::<proc_macro2::Punct>()?;
            let value = input.parse::<LitStr>()?;
            Ok(MacroAttributeThing { name, value, equal })
        }
    }

    impl quote::ToTokens for MacroAttributeThing {
        fn to_tokens(&self, tokens: &mut proc_macro2::TokenStream) {
            let name = &self.name;
            let equal = &self.equal;
            let value = &self.value;
            tokens.extend(quote!(#name #equal #value));
        }
    }

    #[derive(Debug, Default, PartialEq, Eq, Clone)]
    pub struct HlsArguments {
        #[allow(dead_code)]
        pub hls_flags: Option<LitStr>,
        #[allow(dead_code)]
        pub rust_flags: Option<LitStr>,
    }

    impl HlsArguments {
        /// Overlay the current arguments with other arguments
        ///
        /// Other arguments will take precedence
        pub fn overlay(&self, other: &Self) -> Self {
            Self {
                hls_flags: other.hls_flags.clone().or(self.hls_flags.clone()),
                rust_flags: other.rust_flags.clone().or(self.rust_flags.clone()),
            }
        }
    }
    impl syn::parse::Parse for HlsArguments {
        fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
            let args = input.parse_terminated(MacroAttributeThing::parse, Token![,])?;
            let mut args_map: HashMap<_, _> = args
                .into_iter()
                .map(|arg| (arg.name.to_string(), arg))
                .collect();

            let build_arg = args_map.remove("rust_flags");
            let hls_arg = args_map.remove("hls_flags");

            let errors = args_map
                .into_iter()
                .map(|(_, arg)| {
                    let name = arg.name.to_string();
                    syn::Error::new(arg.span(), format!("unexpected argument {}", name))
                })
                .reduce(|mut previous, current| {
                    previous.combine(current);
                    previous
                });

            if let Some(errors) = errors {
                return Err(errors);
            }

            Ok(HlsArguments {
                hls_flags: hls_arg.map(|arg| arg.value),
                rust_flags: build_arg.map(|arg| arg.value),
            })
        }
    }
}

/// Check if the give path looks like a rust_hls macro call
/// This is just a heuristic.
pub fn is_rust_hls_macro(path: &syn::Path) -> bool {
    let segments = &path.segments;
    segments
        .iter()
        .find(|segment| {
            let ident = &segment.ident;
            ident == "hls"
        })
        .is_some()
}

/// Check if the given path looks like a rust_hls macro
///
/// Returns Ok, if the macro is not a rust_hls macro or if it is a valid rust_hls macro
/// Returns Err, if the macro is a rust_hls macro but invalid
pub fn parse_rust_hls_macro(
    attribute: &syn::Attribute,
) -> Result<Option<HlsArguments>, HlsMacroError> {
    let arguments = match &attribute.meta {
        syn::Meta::Path(path) => {
            if !is_rust_hls_macro(&path) {
                None
            } else {
                Some(HlsArguments::default())
            }
        }
        syn::Meta::List(list) => {
            if !is_rust_hls_macro(&list.path) {
                None
            } else {
                let args =
                    syn::parse::<HlsArguments>(list.tokens.clone().into()).or_else(|err| {
                        Err(HlsMacroError::FailedToParseMacroArguments {
                            message: err.to_string(),
                        })
                    })?;
                Some(args)
            }
        }
        syn::Meta::NameValue(_) => None,
    };
    Ok(arguments)
}

/// Extract rust_hls macro information from the given attributes
///
/// Returns Err if there is something wrong with the rust_hls macro
/// Returns Ok(None) if there is no rust_hls macro
/// Returns Ok(Some(HlsArguments)) if there is a rust_hls macro
pub fn extract_rust_hls_macro(
    attributes: &Vec<syn::Attribute>,
) -> Result<Option<HlsArguments>, HlsMacroError> {
    let rust_hls_options: Result<Vec<_>, _> = attributes
        .iter()
        .map(|attribute| {
            // TODO: Fix unwrap
            let arguments = parse_rust_hls_macro(attribute);
            arguments
        })
        .collect();

    let rust_hls_options: Vec<HlsArguments> =
        rust_hls_options?.into_iter().filter_map(|f| f).collect();

    if rust_hls_options.len() > 1 {
        return Err(HlsMacroError::MultipleRustHlsMacros {});
    }

    let rust_hls_options = rust_hls_options.into_iter().nth(0);
    return Ok(rust_hls_options);
}

#[cfg(test)]
mod tests {

    use proc_macro2::Span;
    use syn::punctuated::Punctuated;
    use syn::Token;

    use super::*;

    #[test]
    fn can_detect_thing_that_look_like_rusthls_macros() {
        let valid_path = syn::Path {
            leading_colon: None,
            segments: {
                let mut segments = Punctuated::new();
                segments.push_value(syn::PathSegment {
                    ident: syn::Ident::new("rust_hls_macro", Span::call_site()),
                    arguments: syn::PathArguments::None,
                });
                segments.push_punct(Token![::](Span::call_site()));
                segments.push_value(syn::PathSegment {
                    ident: syn::Ident::new("hls", Span::call_site()),
                    arguments: syn::PathArguments::None,
                });
                segments
            },
        };

        assert_eq!(is_rust_hls_macro(&valid_path), true);

        let invalid_path = syn::Path {
            leading_colon: None,
            segments: {
                let mut segments = Punctuated::new();
                segments.push_value(syn::PathSegment {
                    ident: syn::Ident::new("something", Span::call_site()),
                    arguments: syn::PathArguments::None,
                });
                segments.push_punct(Token![::](Span::call_site()));
                segments.push_value(syn::PathSegment {
                    ident: syn::Ident::new("else", Span::call_site()),
                    arguments: syn::PathArguments::None,
                });
                segments
            },
        };

        assert_eq!(is_rust_hls_macro(&invalid_path), false);
    }
}
