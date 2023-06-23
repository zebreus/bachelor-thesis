use extract_rust_hdl_interface::Signal;
use extract_rust_hdl_interface::{extract_rust_hdl_interface, Direction, SignalType};
use proc_macro2::Ident;
use proc_macro2::TokenStream;
use quote::{format_ident, quote};
use thiserror::Error;

#[cfg(feature = "verilator")]
use crate::buildscript_hls::generate_verilator_shims_from_rusthdl_module;

#[derive(Error, Debug)]
pub enum GenerateRustHdlStructError {
    #[error("Failed to parse generated verilog file")]
    FailedToParseGeneratedVerilogFile,
    #[error("Synthesized verilog module has a different number of arguments than the function")]
    NumberOfParameterDoesNotMatch,
    #[error("Failed to generate the RustHdl struct")]
    GeneratingTheRustHdlStructFailed(#[from] syn::Error),
    #[cfg(feature = "verilator")]
    #[error(transparent)]
    GeneratingVerilatorShimFailed(#[from] crate::buildscript_hls::GenerateVerilatorShimError),
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

pub struct GenerateRustHdlStructResult {
    pub rust_file: syn::File,

    #[cfg(feature = "verilator")]
    pub cpp_shim: crate::rust_hls::CrateFile,
}

#[cfg(feature = "verilator")]
pub fn generate_update_function(
    rust_hdl_module: &extract_rust_hdl_interface::RustHdlModule,
) -> TokenStream {
    let set_values = rust_hdl_module
        .signals
        .iter()
        .filter(|signal| signal.direction == Direction::In || signal.direction == Direction::InOut)
        .map(|signal| {
            let name = format_ident!("{}", signal.name);
            let internal_name = format_ident!("{}", signal.internal_name);

            let value = match signal.signal_type {
                SignalType::Clock => quote! { if self . #name . val() . clk  { 1u8 } else { 0u8 } },
                SignalType::Bit => quote! { if self . #name . val()  { 1u8 } else { 0u8 } },
                SignalType::Bits(x) => {
                    let ty: &str = if x <= 8 {
                        "u8"
                    } else if x <= 16 {
                        "u16"
                    } else if x <= 32 {
                        "u32"
                    } else if x <= 64 {
                        "u64"
                    } else if x <= 128 {
                        "u128"
                    } else {
                        panic!("Unsupported bit width")
                    };
                    let to_correct_size = format_ident!("to_{}", ty);
                    quote! { self . #name . val() . #to_correct_size () }
                }
            };

            let setter = format_ident!("set_{}", internal_name);
            quote! {
                verilated_module . #setter ( #value );
            }
        });

    let get_values = rust_hdl_module
        .signals
        .iter()
        .filter(|signal| signal.direction == Direction::Out || signal.direction == Direction::InOut)
        .map(|signal| {
            let name = format_ident!("{}", signal.name);
            let internal_name = format_ident!("{}", signal.internal_name);

            let value = match signal.signal_type {
                SignalType::Clock => quote! { verilated_module . #internal_name () != 0 },
                SignalType::Bit => quote! { verilated_module . #internal_name () != 0 },
                SignalType::Bits(x) => {
                    let (size, mask): (&str, TokenStream) = if x <= 8 {
                        let mask = u8::MAX >> (8 - x);
                        ("u8", quote!( #mask ))
                    } else if x <= 16 {
                        let mask = u16::MAX >> (16 - x);
                        ("u16", quote!( #mask ))
                    } else if x <= 32 {
                        let mask = u32::MAX >> (32 - x);
                        ("u32", quote!( #mask ))
                    } else if x <= 64 {
                        let mask = u64::MAX >> (64 - x);
                        ("u64", quote!( #mask ))
                    } else if x <= 128 {
                        let mask = u128::MAX >> (128 - x);
                        ("u128", quote!( #mask ))
                    } else {
                        panic!("Unsupported bit width")
                    };
                    let _size_ident = format_ident!("{}", size);
                    let masked_value = quote! { verilated_module . #internal_name () & #mask};
                    let bit_length = x as usize;

                    quote! { rust_hdl::prelude::ToBits::to_bits::<#bit_length>(#masked_value) }
                }
            };

            quote! { self . #name . next = #value ; }
        });

    quote! {
        let mut verilated_module = match self.verilated_module.lock() {
            Ok(verilated_module) => verilated_module,
            Err(e) => {
                panic!("Failed to aquire verilated_module lock: {}", e)
            }
        };

        #(#set_values)*

        verilated_module.eval();

        #(#get_values)*
    }
}

/// Generates a rust file containing a struct that wraps the verilog module.
///
/// ## Arguments
///
/// * `verilog` - A string containing the verilog code.
/// * `function_name` - A string containing the name of the verilog module/rust function
/// * `struct_name` - A string containing the name of the struct that will be generated
/// * `parameter_names` - A vector of strings containing real names of the parameters. See [fix_bambu_llvm_parameters].
pub fn generate_rust_hdl_struct(
    verilog: &str,
    function_name: &str,
    struct_name: &str,
    parameter_names: &Vec<String>,
    #[allow(unused_variables)] source_module_path: &Vec<String>,
) -> Result<GenerateRustHdlStructResult, GenerateRustHdlStructError> {
    // Parse the verilog file
    let mut parsed_module = extract_rust_hdl_interface(&verilog, &function_name).or(Err(
        GenerateRustHdlStructError::FailedToParseGeneratedVerilogFile,
    ))?;
    let module_ident = format_ident!("{}", &parsed_module.name);

    // Adjust the parsed module
    fix_bambu_llvm_parameters(&mut parsed_module.signals, parameter_names)?;
    parsed_module.name = struct_name.to_string();

    #[cfg(feature = "verilator")]
    let verilator_shim = generate_verilator_shims_from_rusthdl_module(
        &parsed_module,
        function_name,
        source_module_path,
    )?;

    #[cfg(feature = "verilator")]
    let verilated_module = {
        let verilated_module = verilator_shim.rust_module;
        quote!(
            #[allow(dead_code, unused)]
            #verilated_module
        )
    };

    #[cfg(not(feature = "verilator"))]
    let verilated_module = quote! {};

    #[cfg(feature = "verilator")]
    let verilated_module_member = {
        let verilated_module = verilator_shim.module_name;
        let verilated_struct = verilator_shim.struct_name;
        quote! {
            verilated_module: ::std::sync::Arc<::std::sync::Mutex<self:: #verilated_module :: #verilated_struct>> ,
        }
    };

    #[cfg(not(feature = "verilator"))]
    let verilated_module_member = quote! {};

    #[cfg(feature = "verilator")]
    let update_function_impl = generate_update_function(&parsed_module);

    #[cfg(not(feature = "verilator"))]
    let update_function_impl = quote! {};

    #[cfg(feature = "verilator")]
    let force_struct_sync = quote!(unsafe impl Send for #module_ident {});

    #[cfg(not(feature = "verilator"))]
    let force_struct_sync = quote! {};

    #[cfg(feature = "verilator")]
    let extern_crate_verilated = quote!(
        extern crate verilated;
    );
    #[cfg(not(feature = "verilator"))]
    let extern_crate_verilated = quote! {};

    // Generate the rust-hdl struct

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

    let create_signals_connect_all = signals.iter().map(|SignalTokens { name, .. }| {
        quote! {
            self.#name.connect_all();
        }
    });

    let create_signals_update_all = signals.iter().map(|SignalTokens { name, .. }| {
        quote! {
            self.#name.update_all();
        }
    });

    let create_signals_has_changed = signals
        .iter()
        .map(|SignalTokens { name, .. }| {
            quote! {
                self.#name.has_changed()
            }
        })
        .chain(std::iter::once(quote! { false }));

    let create_signals_probe = signals.iter().map(|SignalTokens { name, .. }| {
        let name_string = name.to_string();
        quote! {
            self.#name.accept(#name_string, probe);
        }
    });

    let logic_block_impl = quote! {
        #[automatically_derived]
        impl ::rust_hdl::prelude::block::Block for #module_ident {
            fn connect_all(&mut self) {
                self.connect();
                #(#create_signals_connect_all)*
            }
            fn update_all(&mut self) {
                self.update();
                #(#create_signals_update_all)*
            }
            fn has_changed(&self) -> bool {
                #(#create_signals_has_changed ||)* false
            }
            fn accept(&self, name: &str, probe: &mut dyn probe::Probe) {
                probe.visit_start_scope(name, self);
                #(#create_signals_probe)*
                probe.visit_end_scope(name, self);
            }
        }
    };

    let token_stream: syn::File = syn::parse2(quote!(
        #extern_crate_verilated

        use ::rust_hdl::prelude::*;

        #verilated_module

        #[derive(::std::default::Default)]
        pub struct #module_ident {
            #(#signal_definitions)*
            #verilated_module_member
        }

        #force_struct_sync

        #logic_block_impl

        #[automatically_derived]
        impl #module_ident {
            #[allow(unused)]
            pub fn new() -> Self {
                Self::default()
            }
        }

        #[automatically_derived]
        impl ::rust_hdl::prelude::Logic for #module_ident {
            fn update(&mut self) {
                #update_function_impl
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

    return Ok(GenerateRustHdlStructResult {
        rust_file: token_stream,
        #[cfg(feature = "verilator")]
        cpp_shim: verilator_shim.cpp,
    });
}
