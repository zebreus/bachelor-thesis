use extract_rust_hdl_interface::Signal;
use extract_rust_hdl_interface::{extract_rust_hdl_interface, Direction, SignalType};
use proc_macro2::Ident;
use proc_macro2::TokenStream;
use quote::{format_ident, quote};

use thiserror::Error;

#[derive(Error, Debug)]
pub enum GenerateRustHdlStructError {
    #[error("Failed to parse generated verilog file")]
    FailedToParseGeneratedVerilogFile,
    #[error("Synthesized verilog module has a different number of arguments than the function")]
    NumberOfParameterDoesNotMatch,
    #[error("Failed to generate the RustHdl struct")]
    GeneratingTheRustHdlStructFailed(#[from] syn::Error),
}

struct SignalTokens {
    name: Ident,
    ty: TokenStream,
    direction: TokenStream,
    driven: bool,
}

/// Restore the lost parameter names.
///
/// Bambu does not preserve the parameter names in the generated verilog. They get replaced with names like `Pd2`.
///
/// This function finds these names and replaces them with the real ones.
pub fn fix_bambu_llvm_parameters(
    signals: &mut Vec<Signal>,
    ordered_parameter_names: &Vec<String>,
) -> Result<(), GenerateRustHdlStructError> {
    let mut parameter_signals: Vec<&mut Signal> = signals
        .iter_mut()
        .filter(|signal| signal.internal_name.starts_with("Pd"))
        .collect();

    // For now we assume the order to match
    if parameter_signals.len() != ordered_parameter_names.len() {
        return Err(GenerateRustHdlStructError::FailedToParseGeneratedVerilogFile);
    }

    parameter_signals
        .iter_mut()
        .zip(ordered_parameter_names.iter())
        .for_each(|(signal, name)| {
            signal.name = name.to_string();
        });

    return Ok(());
}

/// Generates a rust file containing a struct that wraps the verilog module.
///
/// ## Arguments
///
/// * `verilog` - A string containing the verilog code.
/// * `module_name` - A string containing the name of the verilog module
/// * `struct_name` - A string containing the name of the struct that will be generated
/// * `parameter_names` - A vector of strings containing real names of the parameters. See [fix_bambu_llvm_parameters].
pub fn generate_rust_hdl_struct(
    verilog: &str,
    module_name: &str,
    struct_name: &str,
    parameter_names: &Vec<String>,
) -> Result<syn::File, GenerateRustHdlStructError> {
    // Parse the verilog file
    let mut parsed_module = extract_rust_hdl_interface(&verilog, &module_name).or(Err(
        GenerateRustHdlStructError::FailedToParseGeneratedVerilogFile,
    ))?;

    // Adjust the parsed module
    fix_bambu_llvm_parameters(&mut parsed_module.signals, parameter_names)?;
    parsed_module.name = struct_name.to_string();

    // Generate the rust-hdl struct
    let module_ident = format_ident!("{}", &parsed_module.name);
    let internal_verilog = &parsed_module.internal_verilog();
    let external_verilog = &parsed_module.external_verilog();
    let signals: Vec<SignalTokens> = parsed_module
        .signals
        .iter()
        .map(|signal| SignalTokens {
            name: format_ident!("{}", &signal.name),
            ty: match signal.signal_type {
                SignalType::Bit => quote! { bool },
                SignalType::Bits(x) => {
                    let x = x as usize;
                    quote! { ::rust_hdl::prelude::Bits<#x> }
                }
                SignalType::Clock => quote! { ::rust_hdl::prelude::Clock },
            },
            direction: match signal.direction {
                Direction::In => quote! { ::rust_hdl::prelude::In },
                Direction::Out => quote! { ::rust_hdl::prelude::Out },
                Direction::InOut => quote! { ::rust_hdl::prelude::InOut },
            },
            driven: signal.driven,
        })
        .collect();

    let signal_definitions = signals.iter().map(
        |SignalTokens {
             name,
             ty,
             direction,
             ..
         }| {
            quote! {
                pub #name: rust_hdl::prelude::Signal<#direction , #ty>,
            }
        },
    );

    let create_signal_connections =
        signals
            .iter()
            .filter(|signal| signal.driven)
            .map(|SignalTokens { name, .. }| {
                quote! {
                    self.#name.connect();
                }
            });

    let token_stream: syn::File = syn::parse2(quote!(
        use ::rust_hdl::prelude::*;

        #[derive(::rust_hdl::prelude::LogicBlock, ::std::default::Default)]
        pub struct #module_ident {
            #(#signal_definitions)*
        }

        impl ::rust_hdl::prelude::Logic for #module_ident {
            fn update(&mut self) {
            }
            fn connect(&mut self) {
                #(#create_signal_connections)*
            }
            fn hdl(&self) -> ::rust_hdl::prelude::Verilog {
                // <3>
                ::rust_hdl::prelude::Verilog::Wrapper(::rust_hdl::prelude::Wrapper {
                    code: #internal_verilog.into(),
                    cores: #external_verilog.into(),
                })
            }
        }
    ))?;

    Ok(token_stream)
}
