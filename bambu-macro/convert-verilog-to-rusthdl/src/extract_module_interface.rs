use sv_parser::{unwrap_node, AnsiPortDeclarationNet, Locate, PortDirection, RefNode, SyntaxTree};

pub fn extract_module_interface(ast: &SyntaxTree) -> () {
    let top_module_declaration = find_module_by_name(&ast, "counter").expect("No top level module");
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

fn get_identifier(node: RefNode) -> Option<Locate> {
    // unwrap_node! can take multiple types
    match unwrap_node!(node, SimpleIdentifier, EscapedIdentifier) {
        Some(RefNode::SimpleIdentifier(x)) => {
            return Some(x.nodes.0);
        }
        Some(RefNode::EscapedIdentifier(x)) => {
            return Some(x.nodes.0);
        }
        _ => None,
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

fn get_number_constant(node: RefNode, ast: &SyntaxTree) -> i64 {
    // unwrap_node! can take multiple types
    let value = match unwrap_node!(node, IntegralNumber, RealNumber) {
        Some(RefNode::IntegralNumber(x)) => {
            match unwrap_node!(x, DecimalNumber, OctalNumber, BinaryNumber, HexNumber) {
                Some(RefNode::DecimalNumber(x)) => {
                    let RefNode::UnsignedNumber(unsigned_number) =
                        unwrap_node!(x, UnsignedNumber).unwrap() else {
                        panic!("No UnsignedNumber found");
                        };
                    let locate = unsigned_number.nodes.0;
                    let unsigned_value = ast.get_str(&locate).unwrap();
                    i64::from_str_radix(unsigned_value, 10).unwrap()
                }
                Some(RefNode::OctalNumber(octal_number)) => {
                    let octal_value_node = &octal_number.nodes.2;
                    let locate = octal_value_node.nodes.0;
                    let octal_value = ast.get_str(&locate).unwrap();
                    i64::from_str_radix(octal_value, 8).unwrap()
                }
                Some(RefNode::BinaryNumber(binary_number)) => {
                    let binary_value_node = &binary_number.nodes.2;
                    let locate = binary_value_node.nodes.0;
                    let binary_value = ast.get_str(&locate).unwrap();
                    i64::from_str_radix(binary_value, 2).unwrap()
                }
                Some(RefNode::HexNumber(hex_number)) => {
                    let hex_value_node = &hex_number.nodes.2;
                    let locate = hex_value_node.nodes.0;
                    let hex_value = ast.get_str(&locate).unwrap();
                    i64::from_str_radix(hex_value, 16).unwrap()
                }
                _ => panic!("Should not happen"),
            }
        }

        Some(RefNode::RealNumber(_x)) => {
            panic!("RealNumber not supported yet")
        }
        _ => {
            panic!("Tried to parse a constant number but failed")
        }
    };
    value
}

pub fn analyze_ansi_port_list(port_declaration: &AnsiPortDeclarationNet, ast: &SyntaxTree) -> () {
    let port_identifier_node = unwrap_node!(port_declaration, PortIdentifier).unwrap();
    let port_identifier_locate = get_identifier(port_identifier_node).unwrap();
    let port_identifier = ast.get_str(&port_identifier_locate).unwrap();

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
            let start = get_number_constant((&constant_range.nodes.2).into(), ast);
            let end = get_number_constant((&constant_range.nodes.0).into(), ast);
            let length = end.abs_diff(start) + 1;
            DataType::Bits(length.try_into().unwrap())
        }
        Some(_) => panic!("Unexpected node"),
        None => DataType::Bit,
    };

    println!("port datatype: {:#?}", data_type);
}

pub fn find_module_by_name<'a>(ast: &'a SyntaxTree, name: &str) -> Option<RefNode<'a>> {
    let thing = ast.into_iter().find(|node| {
        match node {
            RefNode::ModuleDeclarationNonansi(x) => {
                // unwrap_node! gets the nearest ModuleIdentifier from x
                let id = unwrap_node!(*x, ModuleIdentifier).unwrap();

                let id = get_identifier(id).unwrap();

                // Original string can be got by SyntaxTree::get_str(self, locate: &Locate)
                let id = ast.get_str(&id).unwrap();
                if id != name {
                    return false;
                }
                return true;
            }
            RefNode::ModuleDeclarationAnsi(x) => {
                let id = unwrap_node!(*x, ModuleIdentifier).unwrap();
                let id = get_identifier(id).unwrap();
                let id = ast.get_str(&id).unwrap();
                if id != name {
                    return false;
                }
                return true;
            }
            _ => return false,
        }
    });
    thing
}
