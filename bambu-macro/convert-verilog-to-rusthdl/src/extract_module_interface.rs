mod analyze_ansi_port_list;
mod find_module_by_name;
mod get_constant_number;
mod get_identifier;

use find_module_by_name::find_module_by_name;
use get_constant_number::get_constant_number;
use get_identifier::get_identifier;
use sv_parser::{unwrap_node, AnsiPortDeclarationNet, PortDirection, RefNode, SyntaxTree};

pub fn extract_module_interface(ast: &SyntaxTree) -> () {
    let top_module_declaration =
        find_module_by_name("counter", ast.into_iter().next().unwrap(), &ast)
            .expect("No top level module");
    match top_module_declaration {
        RefNode::ModuleDeclarationAnsi(x) => {
            let ports = unwrap_node!(x, ListOfPortDeclarations).unwrap();
            let ansi_net_declarations = ports.into_iter().filter_map(|node| match node {
                RefNode::AnsiPortDeclarationNet(x) => Some(x),

                _ => None,
            });

            // println!("port_identifier: ${:#?}", ansi_net_declarations.count());

            ansi_net_declarations
                .map(|port_declaration| analyze_ansi_port_list(port_declaration, ast))
                .count();
        }
        _ => (),
    }
}

#[derive(Debug)]
enum Direction {
    In,
    Out,
    InOut,
}

// #[derive(Debug)]
// enum Type {
//     Wire,
//     Reg,
//     InOut,
// }

#[derive(Debug)]
enum DataType {
    Bit,
    Bits(u32),
}

pub fn analyze_ansi_port_list(port_declaration: &AnsiPortDeclarationNet, ast: &SyntaxTree) -> () {
    let port_identifier_node = unwrap_node!(port_declaration, PortIdentifier).unwrap();
    let port_identifier = get_identifier(port_identifier_node, ast).unwrap();

    println!("port_identifier: {:#?}", port_identifier);

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

    println!("port direction: {:#?}", port_direction);

    let port_datatype = unwrap_node!(net_port_header, NetPortTypeDataType).unwrap();
    let implicit_datatype = unwrap_node!(port_datatype, ImplicitDataType).unwrap();
    let constant_range = unwrap_node!(implicit_datatype, ConstantRange);
    let data_type = match constant_range {
        Some(RefNode::ConstantRange(constant_range)) => {
            let start = get_constant_number((&constant_range.nodes.2).into(), ast)
                .expect("Failed to parse number");
            let end = get_constant_number((&constant_range.nodes.0).into(), ast)
                .expect("Failed to parse number");
            let length = end.abs_diff(start) + 1;
            DataType::Bits(length.try_into().unwrap())
        }
        Some(_) => panic!("Unexpected node"),
        None => DataType::Bit,
    };

    println!("port datatype: {:#?}", data_type);
}
