mod as_pascal_case;
mod as_snake_case;
mod convert_port_to_signal;
mod generate_verilog_body;

pub use generate_verilog_body::generate_verilog_body;

use itertools::Itertools;

use crate::{
    extract_verilog_interface::{extract_verilog_interface, Direction},
    verilog_parser::parse_verilog_string,
};

use self::as_pascal_case::as_pascal_case;

/// Represents a rust-hdl module.
///
/// It should be trivial to generate a wrapping rust-hdl module from this struct.
#[derive(Debug, PartialEq, Eq)]
pub struct RustHdlModule {
    /// Name for the rust-hdl struct
    pub name: String,
    /// The interface of the rust-hdl module
    pub signals: Vec<Signal>,
    /// Name of the verilog module
    verilog_name: String,
    /// Verilog that represents external libraries
    external_verilog: String,
}

impl RustHdlModule {
    pub fn new(verilog_name: String, signals: Vec<Signal>, verilog: String) -> Self {
        RustHdlModule {
            name: as_pascal_case(verilog_name.as_str()),
            verilog_name,
            signals,
            external_verilog: verilog,
        }
    }
    /// Verilog that should be used as the internal logic of the rust-hdl module.
    ///
    /// It just instantiates the external module and connects the ports.
    pub fn internal_verilog(&self) -> String {
        return generate_verilog_body(&self.signals, &self.verilog_name);
    }
    /// Verilog that contains the module that is being wrapped.
    ///
    /// This needs to be included besides the internal verilog.
    pub fn external_verilog(&self) -> &str {
        return self.external_verilog.as_str();
    }
    /// The name of the verilog module that is being wrapped.
    pub fn verilog_name(&self) -> &str {
        return self.verilog_name.as_str();
    }
}

/// The type of a signal.
#[derive(Copy, Clone, Eq, PartialEq, Ord, PartialOrd, Hash, Debug)]
pub enum SignalType {
    Bit,
    Clock,
    Bits(u32),
}

/// Represents a signal in a rust-hdl module.
///
/// Use this to generate the signal types in the struct. `clk: Signal<In, Clock>`
#[derive(Clone, Eq, PartialEq, Ord, PartialOrd, Hash, Debug)]
pub struct Signal {
    /// Name of the signal
    pub name: String,
    /// Internal name of the signal
    pub internal_name: String,
    /// Direction of the signal
    pub direction: Direction,
    /// Datatype of the signal
    pub signal_type: SignalType,
    /// True if the signal is driven from verilog
    pub driven: bool,
}

/// Extract all information needed to generate a wrapping rust-hdl module from a Verilog module.
///
/// # Arguments
///
/// * `verilog` - The original Verilog module that was passed in.
/// * `module_name` - The name of the module that you want to extract.
///
/// # Return
///
/// * `RustHdlModule` - The RustHdlModule struct.
///
/// # Errors
///
/// This function will return an error if there is an error parsing the Verilog
pub fn extract_rust_hdl_interface(
    verilog: &str,
    module_name: &str,
) -> Result<RustHdlModule, sv_parser::Error> {
    let syntax_tree = parse_verilog_string(verilog)?;
    let ports = extract_verilog_interface(&syntax_tree, Some(module_name));
    let signals: Vec<Signal> = ports.iter().map_into().collect();

    let external_verilog = String::from(verilog);

    Ok(RustHdlModule {
        name: as_pascal_case(module_name),
        verilog_name: module_name.into(),
        signals,
        external_verilog,
    })
}

#[cfg(test)]
mod tests {

    use super::*;

    const VERILOG_COUNTER: &str = r#"
    module counter
    (
        input clock,
        output [5:0] led
    );
    
    reg [23:0] clockCounter = 0;
    localparam WAIT_TIME = 1000;
    reg [5:0] ledCounter = 0;
    
    always @(posedge clock) begin
        clockCounter <= clockCounter + 1;
        if (clockCounter == WAIT_TIME) begin
            clockCounter <= 0;
            ledCounter <= ledCounter + 1;
        end
    end
    
    assign led = ~ledCounter;
    endmodule
    "#;

    #[test]
    fn generating_rust_hdl_module_struct_from_counter_works() {
        let rust_hdl_module = extract_rust_hdl_interface(VERILOG_COUNTER, "counter").unwrap();

        assert_eq!(
            rust_hdl_module,
            RustHdlModule {
                name: "Counter".to_string(),
                verilog_name: "counter".to_string(),
                signals: vec![
                    Signal {
                        name: "clock".to_string(),
                        internal_name: "clock".to_string(),
                        direction: Direction::In,
                        signal_type: SignalType::Clock,
                        driven: false,
                    },
                    Signal {
                        name: "led".to_string(),
                        internal_name: "led".to_string(),
                        direction: Direction::Out,
                        signal_type: SignalType::Bits(6),
                        driven: true,
                    },
                ],
                external_verilog: String::from(VERILOG_COUNTER)
            }
        );

        assert_eq!(
            rust_hdl_module.internal_verilog(),
            "counter counter_inst(.clock(clock), .led(led));"
        );
    }

    #[test]
    fn renaming_interface_of_the_rusthdl_module_works() {
        let mut rust_hdl_module = extract_rust_hdl_interface(VERILOG_COUNTER, "counter").unwrap();

        rust_hdl_module.signals.first_mut().map(|first_signal| {
            first_signal.name = "cool_external_name".to_string();
            Some(())
        });

        assert_eq!(
            rust_hdl_module,
            RustHdlModule {
                name: "Counter".to_string(),
                verilog_name: "counter".to_string(),
                signals: vec![
                    Signal {
                        name: "cool_external_name".to_string(),
                        internal_name: "clock".to_string(),
                        direction: Direction::In,
                        signal_type: SignalType::Clock,
                        driven: false,
                    },
                    Signal {
                        name: "led".to_string(),
                        internal_name: "led".to_string(),
                        direction: Direction::Out,
                        signal_type: SignalType::Bits(6),
                        driven: true,
                    },
                ],
                external_verilog: String::from(VERILOG_COUNTER)
            }
        );

        assert_eq!(
            rust_hdl_module.internal_verilog(),
            "counter counter_inst(.clock(cool_external_name), .led(led));"
        );
    }
}
