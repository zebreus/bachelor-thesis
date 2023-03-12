use sv_parser::{unwrap_node, PortDirection, RefNode, SyntaxTree};

use crate::extract_module_interface::get_identifier::get_identifier;

#[derive(Debug, PartialEq, Eq)]
pub enum Direction {
    In,
    Out,
    InOut,
}

// Expects someth
pub fn get_port_direction_ansi(port_net: RefNode) -> Option<Direction> {
    let net_port_header = port_net.into_iter().find_map(|node| match node {
        RefNode::NetPortHeader(x) => Some(x),
        _ => None,
    })?;

    let port_direction = net_port_header.nodes.0.as_ref()?;
    match port_direction {
        PortDirection::Input(_) => Some(Direction::In),
        PortDirection::Output(_) => Some(Direction::Out),
        PortDirection::Inout(_) => Some(Direction::InOut),
        PortDirection::Ref(_) => {
            panic!("Ref not supported because it is only used in SystemVerilog")
        }
    }
}

pub fn get_port_direction_nonansi(port_declaration: RefNode) -> Option<Direction> {
    match unwrap_node!(
        port_declaration,
        InputDeclaration,
        OutputDeclaration,
        InoutDeclaration
    ) {
        Some(RefNode::InputDeclaration(x)) => Some(Direction::In),
        Some(RefNode::OutputDeclaration(x)) => Some(Direction::Out),
        Some(RefNode::InoutDeclaration(x)) => Some(Direction::InOut),
        _ => None,
    }
}

pub fn get_port_direction(port_name: &str, module: RefNode, ast: &SyntaxTree) -> Option<Direction> {
    match unwrap_node!(module, ModuleDeclarationAnsi, ModuleDeclarationNonansi) {
        Some(RefNode::ModuleDeclarationAnsi(x)) => {
            let mut ansi_declaration_nets = x.into_iter().filter_map(|node| match node {
                RefNode::AnsiPortDeclarationNet(x) => Some(node),
                _ => None,
            });

            let ansi_declaration_net = ansi_declaration_nets
                .find(|ansi_declaration_net| {
                    let port_identifier =
                        get_identifier(ansi_declaration_net.clone(), ast).unwrap();
                    port_identifier == port_name
                })
                .unwrap();

            get_port_direction_ansi(ansi_declaration_net)
        }
        Some(RefNode::ModuleDeclarationNonansi(x)) => {
            let mut nonansi_port_declarations = x.into_iter().filter_map(|node| match node {
                RefNode::PortDeclaration(x) => Some(x),
                _ => None,
            });

            let port_declaration = nonansi_port_declarations.find(|port_declaration| {
                let port_identifier_node = unwrap_node!(*port_declaration, PortIdentifier).unwrap();
                let port_identifier = get_identifier(port_identifier_node, ast).unwrap();
                port_identifier == port_name
            });

            match port_declaration {
                Some(port_declaration) => get_port_direction_nonansi(port_declaration.into()),
                None => Some(Direction::In),
            }
        }
        _ => panic!("Module is not ANSI or non-ANSI"),
    }
}

#[cfg(test)]
mod tests {
    use crate::verilog_parser::parse_verilog_string;

    use super::*;

    #[test]
    fn works_with_ansi_input_port() {
        let ast = parse_verilog_string("module alpha(input clock); endmodule").unwrap();
        let port_direction =
            get_port_direction_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap()).unwrap();
        assert_eq!(port_direction, Direction::In);
    }

    #[test]
    fn works_with_ansi_output_port() {
        let ast = parse_verilog_string("module alpha(output clock); endmodule").unwrap();
        let port_direction =
            get_port_direction_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap()).unwrap();
        assert_eq!(port_direction, Direction::Out);
    }

    #[test]
    fn works_with_ansi_inout_port() {
        let ast = parse_verilog_string("module alpha(inout clock); endmodule").unwrap();
        let port_direction =
            get_port_direction_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap()).unwrap();
        assert_eq!(port_direction, Direction::InOut);
    }

    #[test]
    fn works_with_nonansi_input_port() {
        let ast = parse_verilog_string("module alpha(clock); input clock; endmodule").unwrap();
        let port_direction =
            get_port_direction_nonansi(unwrap_node!(&ast, PortDeclaration).unwrap()).unwrap();
        assert_eq!(port_direction, Direction::In);
    }

    #[test]
    fn works_with_nonansi_output_port() {
        let ast = parse_verilog_string("module alpha(clock); output clock; endmodule").unwrap();
        let port_direction =
            get_port_direction_nonansi(unwrap_node!(&ast, PortDeclaration).unwrap()).unwrap();
        assert_eq!(port_direction, Direction::Out);
    }

    #[test]
    fn works_with_nonansi_inout_port() {
        let ast = parse_verilog_string("module alpha(clock); inout clock; endmodule").unwrap();
        let port_direction =
            get_port_direction_nonansi(unwrap_node!(&ast, PortDeclaration).unwrap()).unwrap();
        assert_eq!(port_direction, Direction::InOut);
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_nonansi_module() {
        let ast = parse_verilog_string(
            "module alpha(alpha,beta,gamma); input alpha; output beta; inout gamma; endmodule",
        )
        .unwrap();
        let alpha_direction = get_port_direction(
            "alpha",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        let beta_direction =
            get_port_direction("beta", unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast)
                .unwrap();
        let gamma_direction = get_port_direction(
            "gamma",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        assert_eq!(alpha_direction, Direction::In);
        assert_eq!(beta_direction, Direction::Out);
        assert_eq!(gamma_direction, Direction::InOut);
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_ansi_module() {
        let ast =
            parse_verilog_string("module alpha(input alpha,output beta, inout gamma); endmodule")
                .unwrap();
        let alpha_direction = get_port_direction(
            "alpha",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        let beta_direction =
            get_port_direction("beta", unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast)
                .unwrap();
        let gamma_direction = get_port_direction(
            "gamma",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        assert_eq!(alpha_direction, Direction::In);
        assert_eq!(beta_direction, Direction::Out);
        assert_eq!(gamma_direction, Direction::InOut);
    }
}
