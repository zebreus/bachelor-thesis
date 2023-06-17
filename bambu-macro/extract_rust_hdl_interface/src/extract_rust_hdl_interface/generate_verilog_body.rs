use itertools::Itertools;

use crate::Signal;

/// Generate the body of the Verilog module
pub fn generate_verilog_body(signals: &Vec<Signal>, module_name: &str) -> String {
    let mut port_strings = signals.iter().map(|signal| {
        format!(
            ".{}({})",
            signal.internal_name.as_str(),
            signal.name.as_str()
        )
    });
    let port_string = port_strings.join(", ");
    return format!("{} {}_inst({});", module_name, module_name, port_string);
}

#[cfg(test)]
mod tests {
    use crate::{extract_verilog_interface::Direction, SignalType};

    use super::*;

    #[test]
    fn can_extract_the_interface_of_counter() {
        let ports = Vec::from([
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
        ]);
        let code = generate_verilog_body(&ports, "counter");
        assert_eq!(code, "counter counter_inst(.clock(clock), .led(led));");
    }

    #[test]
    fn puts_external_name_and_internal_name_in_the_right_places() {
        let ports = Vec::from([Signal {
            name: "cool_port".to_string(),
            internal_name: "coolPort".to_string(),
            direction: Direction::Out,
            signal_type: SignalType::Bits(6),
            driven: true,
        }]);
        let code = generate_verilog_body(&ports, "counter");
        assert_eq!(code, "counter counter_inst(.coolPort(cool_port));");
    }
}
