use std::{io, path::PathBuf};

use crate::generated_file::generate_output_filename;
use crate::{generated_file::generate_output_module_path, rust_hls::CrateFile};

use extract_rust_hdl_interface::Direction;
use extract_rust_hdl_interface::{RustHdlModule, SignalType};
use std::panic::catch_unwind;
use syn::{ForeignItem, ImplItem, ItemMod};
use thiserror::Error;

use proc_macro2::{Ident, Span, TokenStream};
use quote::format_ident;
use quote::quote;
use rust_hls_macro_lib::synthesized_struct_name;

#[derive(Error, Debug)]
pub enum GenerateVerilatorShimError {
    #[error("Failed to generate verilator shim")]
    PanickedWhileGeneratingVerilatorShim(),
    #[error(transparent)]
    FailedWhileGeneratingVerilatorShims(#[from] io::Error),
    #[error(transparent)]
    FailedToParseGeneratedError(#[from] syn::Error),
}

pub fn generate_verilator_output_path(source_module_path: &Vec<String>) -> PathBuf {
    let synthesized_module_path = generate_output_module_path(source_module_path);
    let file_path = format!("rust_hls/verilator/{}", synthesized_module_path.join("/"));
    return PathBuf::from(file_path);
}

pub fn generate_verilated_cpp_file_path(
    source_module_path: &Vec<String>,
    function_name: &str,
) -> PathBuf {
    let base_path = generate_verilator_output_path(source_module_path);
    let file_path = base_path.join(format!("{}.cpp", function_name));
    return PathBuf::from(file_path);
}

use syn::visit_mut::VisitMut;

struct TraceFunctionRemover {}

impl TraceFunctionRemover {
    fn new() -> Self {
        Self {}
    }
}

impl VisitMut for TraceFunctionRemover {
    fn visit_item_impl_mut(&mut self, item_impl: &mut syn::ItemImpl) {
        let is_trace_function = |item: &ImplItem| match item {
            syn::ImplItem::Fn(impl_fn) => {
                if impl_fn.sig.ident.to_string() == "open_trace" {
                    true
                } else if impl_fn.sig.ident.to_string() == "trace_at" {
                    true
                } else {
                    false
                }
            }
            _ => false,
        };

        let items = &mut item_impl.items;

        let mut i = 0;
        while i < items.len() {
            if is_trace_function(&items[i]) {
                items.remove(i);
            } else {
                i += 1;
            }
        }

        syn::visit_mut::visit_item_impl_mut(self, item_impl);
    }
    fn visit_item_foreign_mod_mut(&mut self, item_impl: &mut syn::ItemForeignMod) {
        let is_trace_function = |item: &ForeignItem| match item {
            ForeignItem::Fn(impl_fn) => {
                if impl_fn.sig.ident.to_string().ends_with("trace") {
                    true
                } else {
                    false
                }
            }
            _ => false,
        };

        let items = &mut item_impl.items;

        let mut i = 0;
        while i < items.len() {
            if is_trace_function(&items[i]) {
                items.remove(i);
            } else {
                i += 1;
            }
        }
        syn::visit_mut::visit_item_foreign_mod_mut(self, item_impl);
    }
    fn visit_path_mut(&mut self, item_impl: &mut syn::Path) {
        let stringified_path = quote! {#item_impl}.to_string();
        let reference_path = quote!(::verilated::vcd::Vcd).to_string();
        if stringified_path == reference_path {
            *item_impl = syn::parse2(quote!(u32)).unwrap();
        } else {
            syn::visit_mut::visit_path_mut(self, item_impl);
        }
    }
}

/// The generated Rust shim has a dependency on verilated for tracing.
/// This function removes the tracing functions from the generated shim.
fn remove_tracing_functions(verilated_module: &mut ItemMod) -> () {
    let mut visitor = TraceFunctionRemover::new();
    syn::visit_mut::visit_item_mod_mut(&mut visitor, verilated_module);
}

pub struct GeneratedVerilatorShim {
    pub cpp: CrateFile,
    pub rust: CrateFile,
    pub function_name: String,
    pub module_name: Ident,
    pub struct_name: Ident,
    pub rust_module: ItemMod,
}

pub fn generate_verilator_shims_from_rusthdl_module(
    rust_hdl_module: &RustHdlModule,
    // function name
    function_name: &str,
    // source module path
    source_module_path: &Vec<String>,
) -> Result<GeneratedVerilatorShim, GenerateVerilatorShimError> {
    let rust_module_name = format!("{}_verilated", function_name);
    let rust_struct_name = synthesized_struct_name(&rust_module_name);

    let fields: Vec<TokenStream> = rust_hdl_module
        .signals
        .iter()
        .map(|signal| {
            let name = format_ident!("{}", &signal.internal_name);
            let ty = match signal.signal_type {
                SignalType::Bit => quote! { bool },
                SignalType::Bits(x) => {
                    let x = x as usize;
                    quote! { [bool; #x] }
                }
                SignalType::Clock => quote! { bool },
            };
            let attribute = match signal.direction {
                Direction::In => quote! { #[port(input)] },
                Direction::Out => quote! { #[port(output)] },
                Direction::InOut => quote! { #[port(inout)] },
            };
            return quote!( #attribute pub #name: #ty, );
        })
        .collect();
    let function_name_ident = format_ident!("{}", function_name);
    let struct_name_ident = format_ident!("{}", rust_struct_name);

    let rust_module = quote! (
        use verilated_module::module;

        #[module(#function_name_ident)]
        pub struct #struct_name_ident {
            #(#fields)*
        }
    );

    let file = syn::parse2::<syn::File>(rust_module)?;
    let temp_filename = generate_output_filename(source_module_path);

    let module_file = CrateFile {
        path: temp_filename,
        content: prettyplease::unparse(&file),
    };

    generate_verilator_shims(
        &module_file,
        function_name,
        &rust_struct_name,
        &rust_module_name,
        source_module_path,
    )
}

pub fn generate_verilator_shims(
    synthesized_module: &CrateFile,
    // function name / verilog module name
    function_name: &str,
    // ident of the generated struct
    rust_struct_name: &str,
    // ident of the generated module containing the struct
    rust_module_name: &str,
    // source module path
    source_module_path: &Vec<String>,
) -> Result<GeneratedVerilatorShim, GenerateVerilatorShimError> {
    let temp_dir = tempfile::tempdir()?;
    let temp_dir_path = temp_dir.path().to_path_buf();
    let mut cloned_file = synthesized_module.clone();
    let absolute_input_path = temp_dir_path.join(&synthesized_module.path);
    cloned_file.path = absolute_input_path.clone();
    cloned_file.write()?;

    let output_dir = generate_verilator_output_path(source_module_path);
    let absolute_output_dir = temp_dir_path.join(&output_dir);
    std::fs::create_dir_all(&absolute_output_dir)?;

    catch_unwind(|| {
        let mut module = verilator::module::ModuleGenerator::default();

        module
            .out_dir(&absolute_output_dir)
            .generate(&absolute_input_path);
    })
    .or_else(|_| Err(GenerateVerilatorShimError::PanickedWhileGeneratingVerilatorShim()))?;

    let cpp_file_path = output_dir.join(&format!("{}.cpp", function_name));
    let cpp_file_content = std::fs::read_to_string(temp_dir_path.join(&cpp_file_path).as_path())?;

    let rust_file_path = output_dir.join(&format!("{}.rs", rust_struct_name));
    let rust_file_content = std::fs::read_to_string(temp_dir_path.join(&rust_file_path).as_path())?;

    let rust_file: syn::File = syn::parse_str(&rust_file_content)?;
    let mut rust_module = syn::ItemMod {
        attrs: rust_file.attrs,
        vis: syn::Visibility::Inherited,
        mod_token: syn::Token![mod](Span::call_site()),
        ident: format_ident!("{}", rust_module_name),
        content: Some((syn::token::Brace::default(), rust_file.items)),
        semi: None,
        unsafety: None,
    };

    remove_tracing_functions(&mut rust_module);

    return Ok(GeneratedVerilatorShim {
        rust: CrateFile {
            path: rust_file_path,
            content: rust_file_content,
        },
        cpp: CrateFile {
            path: cpp_file_path,
            content: cpp_file_content,
        },
        function_name: function_name.into(),
        module_name: format_ident!("{}", rust_module_name),
        rust_module: rust_module,
        struct_name: format_ident!("{}", rust_struct_name),
    });
}

#[cfg(test)]
mod tests {
    use extract_rust_hdl_interface::extract_rust_hdl_interface;
    use quote::ToTokens;

    use super::*;

    #[test]
    fn generating_verilator_shims_does_not_fail() {
        let input_file = CrateFile {
            path: PathBuf::from("src/cool_synthesized.rs"),
            content: r#"#[module(my_counter)]
            pub struct MyCounterVerilated {
                #[port(input)]
                pub clock: bool,
                #[port(output)]
                pub led: [bool; 7],
            }"#
            .to_string(),
        };

        generate_verilator_shims(
            &input_file,
            "my_counter",
            "MyCounterVerilated",
            "my_counter_verilated",
            &vec!["cool_synthesized".to_string()],
        )
        .unwrap();
    }

    #[test]
    fn generating_verilator_shims_returns_something_that_looks_correct() {
        let input_file = CrateFile {
            path: PathBuf::from("src/cool_synthesized.rs"),
            content: r#"#[module(my_counter)]
            pub struct MyCounterVerilated {
                #[port(input)]
                pub clock: bool,
                #[port(output)]
                pub led: [bool; 7],
            }"#
            .to_string(),
        };

        let result = generate_verilator_shims(
            &input_file,
            "my_counter",
            "MyCounterVerilated",
            "my_counter_verilated",
            &vec!["cool_synthesized".to_string()],
        )
        .unwrap();

        assert!(result.rust.content.contains("impl MyCounterVerilated {"));
        assert!(result.cpp.content.contains("#include <Vmy_counter.h>"));
    }

    #[test]
    fn generating_verilator_shims_from_rusthdl_returns_something_that_looks_correct() {
        let rust_hdl_module = extract_rust_hdl_interface(
            r#"
        module my_counter (clock, led);
        input clock;
        output [6:0] led;
        endmodule"#,
            "my_counter",
        )
        .unwrap();

        let result = generate_verilator_shims_from_rusthdl_module(
            &rust_hdl_module,
            "my_counter",
            &vec!["cool_synthesized".to_string()],
        )
        .unwrap();

        assert!(result.rust.content.contains("impl MyCounterVerilated {"));
        assert!(result.cpp.content.contains("#include <Vmy_counter.h>"));
    }

    #[test]
    fn generated_output_does_not_contain_tracing_functions() {
        let rust_hdl_module = extract_rust_hdl_interface(
            r#"
        module my_counter (clock, led);
        input clock;
        output [6:0] led;
        endmodule"#,
            "my_counter",
        )
        .unwrap();

        let result = generate_verilator_shims_from_rusthdl_module(
            &rust_hdl_module,
            "my_counter",
            &vec!["cool_synthesized".to_string()],
        )
        .unwrap();

        let module_string = result.rust_module.into_token_stream().to_string();

        assert!(!module_string.contains("trace"));
    }

    #[test]
    fn generated_output_removes_verilated_vcd() {
        let rust_hdl_module = extract_rust_hdl_interface(
            r#"
        module my_counter (clock, led);
        input clock;
        output [6:0] led;
        endmodule"#,
            "my_counter",
        )
        .unwrap();

        let result = generate_verilator_shims_from_rusthdl_module(
            &rust_hdl_module,
            "my_counter",
            &vec!["cool_synthesized".to_string()],
        )
        .unwrap();

        let module_string = result.rust_module.into_token_stream().to_string();

        assert!(!module_string.contains("Vcd"));
    }
}
