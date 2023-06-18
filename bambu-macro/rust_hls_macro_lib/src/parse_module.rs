mod check_nested_macros;
mod find_dependencies;
mod find_main_function;
mod remove_hls_macros;
mod super_checker;

use std::collections::HashSet;

pub use check_nested_macros::check_nested_macros;
pub use find_dependencies::find_dependencies;
pub use find_main_function::find_main_function;
pub use remove_hls_macros::remove_hls_macros;
pub use super_checker::check_super;

pub use find_main_function::HlsFunctionInfo;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct HlsModuleContentInformation {
    pub main_function_info: HlsFunctionInfo,
    pub required_dependencies: HashSet<String>,
    pub module: syn::ItemMod,
}

impl HlsModuleContentInformation {
    pub fn get_main(&self) -> Option<&syn::ItemFn> {
        let function_name = &self.main_function_info.function_name;
        let Some((_, items)) = &self.module.content else {return None;};
        items.iter().find_map(|item| {
            let syn::Item::Fn(item_fn) = item else {return None;};
            if &item_fn.sig.ident.to_string() == function_name {
                return None;
            }
            return Some(item_fn);
        })
    }

    pub fn get_main_mut(&mut self) -> Option<&mut syn::ItemFn> {
        let function_name = &self.main_function_info.function_name;
        let Some((_, items)) = &mut self.module.content else {return None;};
        items.iter_mut().find_map(|item| {
            let syn::Item::Fn(item_fn) = item else {return None;};
            if &item_fn.sig.ident.to_string() == function_name {
                return None;
            }
            return Some(item_fn);
        })
    }
}

/// Parse and verify the macro content.
///
/// ## Arguments
/// * `module` - The module to parse.
/// * `available_dependencies` - The external dependencies that are could be used inside the module
pub fn parse_hls_macro_module(
    mut module: syn::ItemMod,
    available_dependencies: &HashSet<String>,
) -> Result<HlsModuleContentInformation, darling::Error> {
    let module_ident_span = module.ident.span().clone();
    let Some((_, items)) = &mut module.content else {
        // TODO: Enable HLS modules in another file
        return Err(darling::Error::custom("HLS modules cannot be in another file (for now)"));
    };

    let main_function_result = find_main_function(items, &module_ident_span);
    remove_hls_macros(items);

    let items: &Vec<syn::Item> = items;
    let check_super_result = check_super(items);
    let find_dependencies_result = find_dependencies(items, &available_dependencies);
    let check_nested_macros_result = check_nested_macros(items);

    // Join errors
    let mut errors = darling::Error::accumulator();
    errors.handle(check_nested_macros_result);
    errors.handle(check_super_result);

    let main_function_info = errors
        .handle(main_function_result)
        .unwrap_or(Default::default());
    let required_dependencies = errors
        .handle(find_dependencies_result)
        .unwrap_or(Default::default());

    errors.finish_with(HlsModuleContentInformation {
        main_function_info,
        required_dependencies,
        module: module,
    })
}

#[cfg(test)]
mod tests {
    use std::collections::HashSet;

    use super::parse_hls_macro_module;

    #[test]
    fn can_parse_valid_module() {
        let input: syn::ItemMod = syn::parse2(::quote::quote! {
            #[hls]
            mod main {
                #[no_mangle]
                #[hls]
                extern fn cool_function() {}
            }
        })
        .unwrap();

        let result = parse_hls_macro_module(input, &HashSet::new()).unwrap();
        assert_eq! {result.required_dependencies, HashSet::new()};
        assert_eq! {result.main_function_info.function_name, "cool_function"};
        assert_eq! {result.main_function_info.parameters.len(), 0};
    }

    #[test]
    fn detects_double_function() {
        let input: syn::ItemMod = syn::parse2(::quote::quote! {
            #[hls]
            mod main {
                #[no_mangle]
                extern fn cool_function() {}
            }
        })
        .unwrap();

        parse_hls_macro_module(input, &HashSet::new()).unwrap_err();
    }
}
