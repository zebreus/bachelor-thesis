use itertools::Itertools;

use crate::{extract_rust_hdl_interface::as_snake_case, extract_verilog_interface::Port};

/// Generate the body of the Verilog module
pub fn generate_verilog_body(ports: Vec<Port>, module_name: &str) -> String {
    let mut port_strings = ports.iter().map(|port| {
        format!(
            ".{}({})",
            port.identifier.as_str(),
            as_snake_case(port.identifier.as_str())
        )
    });
    let port_string = port_strings.join(", ");
    return format!("{} {}_inst({});", module_name, module_name, port_string);
}

#[cfg(test)]
mod tests {
    use crate::extract_verilog_interface::{DataSize, Direction, NetType};

    use super::*;

    #[test]
    fn can_extract_the_interface_of_counter() {
        let ports = Vec::from([
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bit,
                net_type: NetType::Wire,
            },
            Port {
                identifier: "led".to_string(),
                direction: Direction::Out,
                data_size: DataSize::Bits(6),
                net_type: NetType::Wire,
            },
        ]);
        let code = generate_verilog_body(ports, "counter");
        assert_eq!(code, "counter counter_inst(.clock(clock), .led(led));");
    }

    #[test]
    fn converts_external_ports_to_snake_case() {
        let ports = Vec::from([Port {
            identifier: "coolPort".to_string(),
            direction: Direction::In,
            data_size: DataSize::Bit,
            net_type: NetType::Wire,
        }]);
        let code = generate_verilog_body(ports, "counter");
        assert_eq!(code, "counter counter_inst(.coolPort(cool_port));");
    }
}
