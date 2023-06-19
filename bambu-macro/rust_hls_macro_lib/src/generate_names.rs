use convert_case::{Case, Casing};

pub fn synthesized_module_name(original_module_name: &str) -> String {
    return format!("{}_synthesized", original_module_name);
}

pub fn synthesized_struct_name(original_function_name: &str) -> String {
    return format!("{}", original_function_name.to_case(Case::Pascal));
}
