use super::get_constant_number::get_constant_number;
use super::get_identifier::get_identifier;
use sv_parser::{unwrap_node, AnsiPortDeclarationNet, PortDirection, RefNode, SyntaxTree};

#[derive(Debug, PartialEq, Eq)]

pub struct Port {
    pub identifier: String,
    pub direction: Direction,
    pub port_type: PortType,
    pub data_size: DataSize,
}

#[derive(Debug, PartialEq, Eq)]
pub enum Direction {
    In,
    Out,
    InOut,
}

#[derive(Debug, PartialEq, Eq)]
pub enum PortType {
    Wire,
    Reg,
}

#[derive(Debug, PartialEq, Eq)]
pub enum DataSize {
    Bit,
    Bits(u32),
}

pub fn get_port_identifier(port_declaration: &AnsiPortDeclarationNet, ast: &SyntaxTree) -> String {
    let port_identifier_node = unwrap_node!(port_declaration, PortIdentifier).unwrap();
    let port_identifier = get_identifier(port_identifier_node, ast).unwrap();
    String::from(port_identifier)
}

pub fn get_port_direction(
    port_declaration: &AnsiPortDeclarationNet,
    ast: &SyntaxTree,
) -> Direction {
    let net_port_header = port_declaration
        .into_iter()
        .find_map(|node| match node {
            RefNode::NetPortHeader(x) => Some(x),
            _ => None,
        })
        .unwrap();

    let port_direction = net_port_header.nodes.0.as_ref().unwrap();
    let port_direction = match port_direction {
        PortDirection::Input(_) => Direction::In,
        PortDirection::Output(_) => Direction::Out,
        PortDirection::Inout(_) => Direction::InOut,
        PortDirection::Ref(_) => {
            panic!("Ref not supported because it is only used in SystemVerilog")
        }
    };
    port_direction
}

pub fn get_port_data_size(port_declaration: &AnsiPortDeclarationNet, ast: &SyntaxTree) -> DataSize {
    let net_port_header = port_declaration
        .into_iter()
        .find_map(|node| match node {
            RefNode::NetPortHeader(x) => Some(x),
            _ => None,
        })
        .unwrap();

    let port_datatype = unwrap_node!(net_port_header, NetPortTypeDataType).unwrap();
    let implicit_datatype = unwrap_node!(port_datatype, ImplicitDataType).unwrap();
    let constant_range = unwrap_node!(implicit_datatype, ConstantRange);
    let data_size = match constant_range {
        Some(RefNode::ConstantRange(constant_range)) => {
            let start = get_constant_number((&constant_range.nodes.2).into(), ast)
                .expect("Failed to parse number");
            let end = get_constant_number((&constant_range.nodes.0).into(), ast)
                .expect("Failed to parse number");
            let length = end.abs_diff(start) + 1;
            DataSize::Bits(length.try_into().unwrap())
        }
        Some(_) => panic!("Unexpected node"),
        None => DataSize::Bit,
    };
    data_size
}

pub fn analyze_ansi_port_list(node: RefNode, ast: &SyntaxTree) -> Vec<Port> {
    let ports = unwrap_node!(node, ListOfPortDeclarations).unwrap();

    let ansi_port_declaration_nets = ports.into_iter().filter_map(|node| match node {
        RefNode::AnsiPortDeclarationNet(x) => Some(x),
        _ => None,
    });

    let result = ansi_port_declaration_nets.map(|port_declaration_net| {
        let port_identifier = get_port_identifier(port_declaration_net, ast);
        println!("port_identifier: {:#?}", port_identifier);

        let port_direction = get_port_direction(port_declaration_net, ast);
        println!("port direction: {:#?}", port_direction);

        let data_size = get_port_data_size(port_declaration_net, ast);

        println!("port data_size: {:#?}", data_size);

        Port {
            identifier: port_identifier,
            direction: port_direction,
            data_size: data_size,
            port_type: PortType::Wire,
        }
    });

    let ports: Vec<Port> = result.collect();
    ports
}

#[cfg(test)]
mod tests {
    use crate::{
        extract_module_interface::find_module_by_name, verilog_parser::parse_verilog_string,
    };

    use super::*;

    #[test]
    fn should_work_with_a_basic_module() {
        let ast =
            parse_verilog_string("module alpha(input clock, output [5:0] led); endmodule").unwrap();
        let ports = analyze_ansi_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 2);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bit,
                port_type: PortType::Wire,
            }
        );
        assert_eq!(
            ports[1],
            Port {
                identifier: "led".to_string(),
                direction: Direction::Out,
                data_size: DataSize::Bits(6),
                port_type: PortType::Wire,
            }
        );
    }
}
