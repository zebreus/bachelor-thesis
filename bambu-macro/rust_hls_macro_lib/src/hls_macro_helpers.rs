//! Functions that make it easier to parse rust_hls macros

use crate::{parse_hls_macro_args, HlsMacroArguments};
use syn::spanned::Spanned;

/// Check if path looks like a rust_hls macro call
///
/// This is just a heuristic, as we dont know the exact path
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

/// Try to parse a rust_hls macro from an attribute
///
/// Should only be called on macros that are known to be rust_hls macros
pub fn parse_hls_macro_attribute(
    attribute: &syn::Attribute,
) -> Result<Option<HlsMacroArguments>, darling::Error> {
    let mut errors = darling::Error::accumulator();
    // let errorsRef = &mut errors;

    let path = attribute.meta.path();
    if !is_rust_hls_macro(&path) {
        return errors.finish_with(None);
    }

    let arguments = match &attribute.meta {
        syn::Meta::Path(_) => Some(HlsMacroArguments::default()),
        syn::Meta::List(list) => match parse_hls_macro_args(list.tokens.clone()) {
            Ok(v) => Some(v),
            Err(e) => {
                errors.push(e);
                None
            }
        },
        syn::Meta::NameValue(_) => {
            errors.push(
                darling::Error::custom("hls macro cannot be a name-value pair")
                    .with_span(&attribute.span()),
            );
            None
        }
    };

    errors.finish_with(arguments)
}

/// Extract rust_hls macro information from the given attributes
///
/// Returns Err if there is something wrong with the rust_hls macro
/// Returns Ok(None) if there is no rust_hls macro
/// Returns Ok(Some(HlsArguments)) if there is a rust_hls macro
pub fn extract_hls_macro(
    attributes: &Vec<syn::Attribute>,
) -> Result<Option<HlsMacroArguments>, darling::Error> {
    let mut errors = darling::Error::accumulator();

    let rust_hls_options: Option<HlsMacroArguments> =
        attributes.iter().fold(Option::None, |first, attribute| {
            let arguments = parse_hls_macro_attribute(attribute);
            let arguments = errors.handle(arguments);
            let arguments = match arguments {
                Some(Some(v)) => Some(v),
                _ => None,
            };

            match first {
                Some(_) => {
                    if arguments.is_some() {
                        errors.push(
                            darling::Error::custom("Multiple hls macros")
                                .with_span(&attribute.span()),
                        );
                    }
                    first
                }
                None => arguments,
            }
        });

    errors.finish_with(rust_hls_options)
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
