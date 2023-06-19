use quote::ToTokens;
use syn::{visit_mut::VisitMut, Meta};

use crate::is_rust_hls_macro;

struct MakeContentCompileVisitor {}

impl MakeContentCompileVisitor {
    fn new() -> Self {
        Self {}
    }
}

#[doc()]
impl VisitMut for MakeContentCompileVisitor {
    fn visit_attribute_mut(&mut self, attribute: &mut syn::Attribute) {
        if is_rust_hls_macro(attribute.path()) {
            attribute.meta = Meta::List(syn::parse_quote!(doc()));
        }
    }
}

/// Modify the content of the HLS macro module so it is valid Rust code
///
/// This can be used in case the main macro failed, so that rust-analyzer can still parse the code.
///
/// The main feature of this function is that it never fails.
pub fn make_content_compile(stream: proc_macro2::TokenStream) -> proc_macro2::TokenStream {
    let mut item: syn::Item = match syn::parse2(stream.clone()) {
        Ok(item) => item,
        Err(_) => {
            return stream;
        }
    };

    let mut visitor = MakeContentCompileVisitor::new();

    syn::visit_mut::visit_item_mut(&mut visitor, &mut item);

    item.into_token_stream()
}
