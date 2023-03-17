mod get_port_data_size;
mod get_port_direction;
mod get_port_identifiers;
mod get_port_net_type;

use get_port_direction::get_port_direction;
pub use get_port_direction::Direction;
use itertools::Itertools;

use self::get_port_data_size::get_port_data_size;
pub use self::get_port_data_size::DataSize;
use self::get_port_identifiers::get_port_identifiers;
use self::get_port_net_type::get_port_net_type;
pub use self::get_port_net_type::NetType;

use sv_parser::{RefNode, SyntaxTree};

#[derive(Debug, PartialEq, Eq, Clone)]
pub struct Port {
    pub identifier: String,
    pub direction: Direction,
    pub net_type: NetType,
    pub data_size: DataSize,
}

pub fn analyze_port_list(module: RefNode, ast: &SyntaxTree) -> Vec<Port> {
    // let ports = match unwrap_node!(node, ListOfPortDeclarations) {

    let identifiers = get_port_identifiers(module.clone(), ast);

    let ports = identifiers.into_iter().filter_map(|identifier| {
        let port_direction = get_port_direction(identifier.as_str(), module.clone(), ast)?;
        let data_size = get_port_data_size(identifier.as_str(), module.clone(), ast)?;
        let net_type = get_port_net_type(identifier.as_str(), module.clone(), ast)?;

        Some(Port {
            identifier: identifier,
            direction: port_direction,
            data_size: data_size,
            net_type: net_type,
        })
    });

    ports.collect_vec()

    //     Some(x) => x,
    //     None => return vec![],
    // };

    // let ansi_port_declaration_nets = ports.into_iter().filter_map(|node| match node {
    //     RefNode::AnsiPortDeclarationNet(x) => Some(x),
    //     _ => None,
    // });

    // let result = ansi_port_declaration_nets.map(|port_declaration_net| {
    //     let port_identifier = get_port_identifier(port_declaration_net, ast);
    //     println!("port_identifier: {:#?}", port_identifier);

    //     let port_direction = get_port_direction_ansi(port_declaration_net.into()).unwrap();
    //     println!("port direction: {:#?}", port_direction);

    //     let data_size = get_port_data_size(port_declaration_net, ast);
    //     println!("port data_size: {:#?}", data_size);

    //     let net_type = get_port_net_type(port_declaration_net, ast);

    //     Port {
    //         identifier: port_identifier,
    //         direction: port_direction,
    //         data_size: data_size,
    //         net_type: net_type,
    //     }
    // });

    // let ports: Vec<Port> = result.collect();
    // ports
}

#[cfg(test)]
mod tests {
    use sv_parser::unwrap_node;

    use crate::verilog_parser::parse_verilog_string;

    use super::*;

    #[test]
    fn should_work_with_a_basic_module() {
        let ast =
            parse_verilog_string("module alpha(input clock, output [5:0] led); endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 2);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bit,
                net_type: NetType::Wire,
            }
        );
        assert_eq!(
            ports[1],
            Port {
                identifier: "led".to_string(),
                direction: Direction::Out,
                data_size: DataSize::Bits(6),
                net_type: NetType::Wire,
            }
        );
    }

    #[test]
    fn should_work_with_a_basic_nonansi_module() {
        let ast = parse_verilog_string(
            "module alpha(clock, led); input clock; output [5:0] led; endmodule",
        )
        .unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 2);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bit,
                net_type: NetType::Wire,
            }
        );
        assert_eq!(
            ports[1],
            Port {
                identifier: "led".to_string(),
                direction: Direction::Out,
                data_size: DataSize::Bits(6),
                net_type: NetType::Wire,
            }
        );
    }

    #[test]
    fn should_work_with_a_module_without_ports() {
        let ast = parse_verilog_string("module alpha(); endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 0);
    }

    #[test]
    fn should_work_with_an_input_port() {
        let ast = parse_verilog_string("module alpha(input clock); endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bit,
                net_type: NetType::Wire,
            }
        );
    }

    #[test]
    fn should_work_with_an_output_port() {
        let ast = parse_verilog_string("module alpha(output clock); endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::Out,
                data_size: DataSize::Bit,
                net_type: NetType::Wire,
            }
        );
    }

    #[test]
    fn should_work_with_an_input_output_port() {
        let ast = parse_verilog_string("module alpha(inout clock); endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::InOut,
                data_size: DataSize::Bit,
                net_type: NetType::Wire,
            }
        );
    }

    #[test]
    fn should_work_with_a_sized_port() {
        let ast = parse_verilog_string("module alpha(input [7:0] clock); endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bits(8),
                net_type: NetType::Wire,
            }
        );
    }

    #[test]
    fn should_work_with_a_single_bit_sized_port() {
        let ast = parse_verilog_string("module alpha(input [0:0] clock); endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bits(1),
                net_type: NetType::Wire,
            }
        );
    }

    #[test]
    fn should_work_with_specified_reg_net_type() {
        let ast = parse_verilog_string("module alpha(input reg clock); endmodule").unwrap();

        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bit,
                net_type: NetType::Reg,
            }
        );
    }

    #[test]
    fn should_work_with_specified_wire_net_type() {
        let ast = parse_verilog_string("module alpha(input wire clock); endmodule").unwrap();

        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
        assert_eq!(ports[0].net_type, NetType::Wire);
    }

    #[test]
    fn should_work_with_nonansi_module() {
        let ast = parse_verilog_string("module alpha(clock); input clock; endmodule").unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 1);
    }
}
