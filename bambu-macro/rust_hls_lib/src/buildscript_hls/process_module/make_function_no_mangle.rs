use syn::ItemFn;

pub fn make_function_no_mangle(function: &mut ItemFn) -> () {
    let is_no_mangle = function
        .attrs
        .iter()
        .find(|attr| attr.path().is_ident("no_mangle"));

    match is_no_mangle {
        Some(_) => {}
        None => {
            function.attrs.push(syn::parse_quote!(#[no_mangle]));
        }
    }
}
