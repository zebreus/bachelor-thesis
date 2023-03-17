//! Provides a [`wrap_verilog!`] macro that can be used to wrap a verilog module in a Rust struct.
//!
//! ## Example
//!
//! ```rust
//! use wrap_verilog_in_rust_hdl_macro::wrap_verilog;
//!
//! wrap_verilog!("module test(); endmodule", "test");
//! ```
//!
//! ### Bigger example
//!
//! In this example we are going to wrap the following Verilog module:
//!
//! ```verilog
//! module counter
//! (
//!     input clock,
//!     output [5:0] led
//! );
//!     reg [23:0] clockCounter = 0;
//!     localparam WAIT_TIME = 1000;
//!     reg [5:0] ledCounter = 0;
//!     
//!     always @(posedge clock) begin
//!         clockCounter <= clockCounter + 1;
//!         if (clockCounter == WAIT_TIME) begin
//!             clockCounter <= 0;
//!             ledCounter <= ledCounter + 1;
//!         end
//!     end
//!     
//!     assign led = ~ledCounter;
//! endmodule
//! ```
//!
//! To generate a rust-hdl compatible struct we can use the [`wrap_verilog!`] macro. The macro takes a string literal containing Verilog and the module name as inputs.
//!
//! ```rust
//! use wrap_verilog_in_rust_hdl_macro::wrap_verilog;
//!
//! wrap_verilog!(
//! r#"
//! module counter
//! (
//!     input clock,
//!     output [5:0] led
//! );
//!
//! reg [23:0] clockCounter = 0;
//! localparam WAIT_TIME = 1000;
//! reg [5:0] ledCounter = 0;
//!
//! always @(posedge clock) begin
//!     clockCounter <= clockCounter + 1;
//!     if (clockCounter == WAIT_TIME) begin
//!         clockCounter <= 0;
//!         ledCounter <= ledCounter + 1;
//!     end
//! end
//!
//! assign led = ~ledCounter;
//! endmodule
//! "#,
//!     "counter"
//! );
//! ```
//!
//! This expands to the following struct and logic implementation:
//!
//! ```rust
//! use rust_hdl::prelude::*;
//! #[derive(LogicBlock, Default)]
//! struct Counter {
//!     pub clock: Signal<
//!         In,
//!         Clock,
//!     >,
//!     pub led: Signal<
//!         Out,
//!         Bits<6usize>,
//!     >,
//! }
//!
//! impl Logic for Counter {
//!     fn update(&mut self) {}
//!     fn connect(&mut self) {
//!         self.led.connect();
//!     }
//!     fn hdl(&self) -> Verilog {
//!         Verilog::Wrapper(Wrapper {
//!             code: "counter counter_inst(.clock(clock), .led(led));".into(),
//!             cores: r#"
//!                 module counter
//!                 (
//!                     input clock,
//!                     output [5:0] led
//!                 );
//!                 
//!                 reg [23:0] clockCounter = 0;
//!                 localparam WAIT_TIME = 1000;
//!                 reg [5:0] ledCounter = 0;
//!                 
//!                 always @(posedge clock) begin
//!                     clockCounter <= clockCounter + 1;
//!                     if (clockCounter == WAIT_TIME) begin
//!                         clockCounter <= 0;
//!                         ledCounter <= ledCounter + 1;
//!                     end
//!                 end
//!                 
//!                 assign led = ~ledCounter;
//!                 endmodule
//!                 "#.into(),
//!         })
//!     }
//! }
//! ```
//!
//! ## Limitations
//!
//! * The generated module is just a rust-hdl wrapper around verilog.
//! * The generated module can not be simulated with rust-hdl because it does not support simulating verilog.
//! * You need to explicitly specify the name of the toplevel module, as we cannot detect it automatically.
//!
use extract_rust_hdl_interface::{extract_rust_hdl_interface, Direction, SignalType};
use proc_macro2::Ident;
use proc_macro2::TokenStream;
use proc_macro_error::{abort, proc_macro_error};
use quote::{format_ident, quote};
use syn::{parse_macro_input, LitStr};

struct WrapVerilogArguments {
    verilog: LitStr,
    module_name: LitStr,
}

impl syn::parse::Parse for WrapVerilogArguments {
    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
        let verilog = input.parse::<syn::LitStr>()?;
        input.parse::<syn::Token![,]>()?;
        let module_name = input.parse::<syn::LitStr>()?;
        Ok(WrapVerilogArguments {
            verilog,
            module_name,
        })
    }
}

struct SignalTokens {
    name: Ident,
    ty: TokenStream,
    direction: TokenStream,
    driven: bool,
}

/// Wrap a verilog module in a Rust struct.
///
/// ## Example
///
/// ```rust
/// use wrap_verilog_in_rust_hdl_macro::wrap_verilog;
///
/// wrap_verilog!("module test(); endmodule", "test");
/// ```
///
/// Expands to a rust-hdl struct named "Test".
///
/// ## Arguments
///
/// * `verilog` - A string literal containing the verilog code.
/// * `top_level_module` - A string literal containing the name of the top level module.
#[proc_macro_error]
#[proc_macro]
pub fn wrap_verilog(input: proc_macro::TokenStream) -> proc_macro::TokenStream {
    // let mut iterator = input.into_iter();
    let arguments = parse_macro_input!(input as WrapVerilogArguments);

    let parsed_module =
        extract_rust_hdl_interface(&arguments.verilog.value(), &arguments.module_name.value())
            .unwrap_or_else(|error| {
                abort!(arguments.verilog.span(), error.to_string().as_str());
            });

    let module_ident = format_ident!("{}", &parsed_module.name);
    let internal_verilog = &parsed_module.internal_verilog;
    let external_verilog = &parsed_module.external_verilog;
    let signals: Vec<SignalTokens> = parsed_module
        .signals
        .iter()
        .map(|signal| SignalTokens {
            name: format_ident!("{}", &signal.name),
            ty: match signal.signal_type {
                SignalType::Bit => quote! { bool },
                SignalType::Bits(x) => {
                    let x = x as usize;
                    quote! { rust_hdl::prelude::Bits<#x> }
                }
                SignalType::Clock => quote! { rust_hdl::prelude::Clock },
            },
            direction: match signal.direction {
                Direction::In => quote! { rust_hdl::prelude::In },
                Direction::Out => quote! { rust_hdl::prelude::Out },
                Direction::InOut => quote! { rust_hdl::prelude::InOut },
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

    return quote!(
        use rust_hdl::prelude::*;

        #[derive(rust_hdl::prelude::LogicBlock, std::default::Default)]
        struct #module_ident {
            #(#signal_definitions)*
        }

        impl rust_hdl::prelude::Logic for #module_ident {
            fn update(&mut self) {
            }
            fn connect(&mut self) {
                #(#create_signal_connections)*
            }
            fn hdl(&self) -> rust_hdl::prelude::Verilog {
                // <3>
                rust_hdl::prelude::Verilog::Wrapper(rust_hdl::prelude::Wrapper {
                    code: #internal_verilog.into(),
                    cores: #external_verilog.into(),
                })
            }
        }
    )
    .into();
}
