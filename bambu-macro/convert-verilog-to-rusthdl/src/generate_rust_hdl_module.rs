mod as_pascal_case;
mod as_snake_case;
mod convert_port_to_signal;
mod generate_verilog_body;

use as_snake_case::as_snake_case;

pub use generate_verilog_body::generate_verilog_body;

use itertools::Itertools;

use crate::{
    extract_module_interface::{extract_module_interface, Direction},
    verilog_parser::parse_verilog_string,
};

use self::as_pascal_case::as_pascal_case;

#[derive(Debug, PartialEq, Eq)]
pub struct RustHdlModule {
    /// Name for the rust-hdl struct
    pub name: String,
    pub signals: Vec<Signal>,
    /// Verilog that represents the logic of our module
    pub internal_verilog: String,
    /// Verilog that represents external libraries
    pub external_verilog: String,
}

#[derive(Debug, PartialEq, Eq)]
pub enum SignalType {
    Bit,
    Clock,
    Bits(u32),
}

#[derive(Debug, PartialEq, Eq)]
pub struct Signal {
    /// Name of the signal
    pub name: String,
    /// Direction of the signal
    pub direction: Direction,
    /// Datatype of the signal
    pub signal_type: SignalType,
    /// True if the signal is driven from verilog
    pub driven: bool,
}

pub fn generate_rust_hdl_module(
    verilog: &str,
    module_name: &str,
) -> Result<RustHdlModule, sv_parser::Error> {
    let syntax_tree = parse_verilog_string(verilog)?;
    let ports = extract_module_interface(&syntax_tree, Some(module_name));
    let signals: Vec<Signal> = ports.iter().map_into().collect();

    let internal_verilog = generate_verilog_body(ports, module_name);
    let external_verilog = String::from(verilog);

    Ok(RustHdlModule {
        name: as_pascal_case(module_name),
        signals,
        internal_verilog,
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
        let rust_hdl_module = generate_rust_hdl_module(VERILOG_COUNTER, "counter").unwrap();

        assert_eq!(
            rust_hdl_module,
            RustHdlModule {
                name: "Counter".to_string(),
                signals: vec![
                    Signal {
                        name: "clock".to_string(),
                        direction: Direction::In,
                        signal_type: SignalType::Clock,
                        driven: false,
                    },
                    Signal {
                        name: "led".to_string(),
                        direction: Direction::Out,
                        signal_type: SignalType::Bits(6),
                        driven: true,
                    },
                ],
                internal_verilog: String::from("counter counter_inst(.clock(clock), .led(led));"),
                external_verilog: String::from(VERILOG_COUNTER)
            }
        );
    }
}
