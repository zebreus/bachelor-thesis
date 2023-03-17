use crate::extract_verilog_interface::get_identifier::get_identifier;

use sv_parser::{unwrap_node, RefNode, SyntaxTree};

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum NetType {
    Wire,
    Reg,
}

pub fn get_port_net_type_ansi(port_declaration: RefNode, ast: &SyntaxTree) -> Option<NetType> {
    let net_port_type = unwrap_node!(port_declaration, NetPortType).unwrap();
    let next_keyword = unwrap_node!(net_port_type, Keyword);

    let result = match next_keyword {
        Some(RefNode::Keyword(keyword_node)) => {
            let keyword_locate = keyword_node.nodes.0;
            let keyword = ast.get_str(&keyword_locate).unwrap();
            match keyword {
                "wire" => NetType::Wire,
                "reg" => NetType::Reg,
                _ => NetType::Wire,
            }
        }
        _ => NetType::Wire,
    };
    Some(result)
}

pub fn get_port_net_type(port_name: &str, module: RefNode, ast: &SyntaxTree) -> Option<NetType> {
    match unwrap_node!(module, ModuleDeclarationAnsi, ModuleDeclarationNonansi) {
        Some(RefNode::ModuleDeclarationAnsi(x)) => {
            let mut ansi_declaration_nets = x.into_iter().filter_map(|node| match node {
                RefNode::AnsiPortDeclarationNet(_) => Some(node),
                _ => None,
            });

            let ansi_declaration_net = ansi_declaration_nets
                .find(|ansi_declaration_net| {
                    let port_identifier =
                        get_identifier(ansi_declaration_net.clone(), ast).unwrap();
                    port_identifier == port_name
                })
                .unwrap();

            get_port_net_type_ansi(ansi_declaration_net, &ast)
        }
        Some(RefNode::ModuleDeclarationNonansi(x)) => {
            let nonansi_port_declarations = x.into_iter().filter_map(|node| match node {
                RefNode::PortDeclaration(x) => Some(x),
                _ => None,
            });

            let matching_port_declarations =
                nonansi_port_declarations.filter_map(|port_declaration| {
                    let port_identifier_node =
                        unwrap_node!(port_declaration, PortIdentifier).unwrap();
                    let port_identifier = get_identifier(port_identifier_node, ast).unwrap();
                    if port_identifier != port_name {
                        None
                    } else {
                        Some(port_declaration)
                    }
                });

            let port_type =
                matching_port_declarations.fold(NetType::Wire, |acc, port_declaration| {
                    let port_data_size =
                        get_port_net_type_ansi(port_declaration.into(), &ast).unwrap();
                    match port_data_size {
                        NetType::Reg => NetType::Reg,
                        _ => acc,
                    }
                });

            Some(port_type)
        }
        _ => panic!("Module is not ANSI or non-ANSI"),
    }
}

#[cfg(test)]
mod tests {
    use crate::verilog_parser::parse_verilog_string;

    use super::*;

    #[test]
    fn works_with_ansi_without_specification() {
        let ast = parse_verilog_string("module alpha(input clock); endmodule").unwrap();
        let port_direction =
            get_port_net_type_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, NetType::Wire);
    }

    #[test]
    fn works_with_ansi_with_wire() {
        let ast = parse_verilog_string("module alpha(input wire clock); endmodule").unwrap();
        let port_direction =
            get_port_net_type_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, NetType::Wire);
    }

    #[test]
    fn works_with_ansi_with_reg() {
        let ast = parse_verilog_string("module alpha(input reg clock); endmodule").unwrap();
        let port_direction =
            get_port_net_type_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, NetType::Reg);
    }

    #[test]
    fn works_with_nonansi_without_specification() {
        let ast = parse_verilog_string("module alpha(clock); input clock; endmodule").unwrap();
        let port_direction =
            get_port_net_type_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, NetType::Wire);
    }

    #[test]
    fn works_with_nonansi_with_wire() {
        let ast = parse_verilog_string("module alpha(clock); input wire clock; endmodule").unwrap();
        let port_direction =
            get_port_net_type_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, NetType::Wire);
    }

    #[test]
    fn works_with_nonansi_with_reg() {
        let ast = parse_verilog_string("module alpha(clock); input reg clock; endmodule").unwrap();
        let port_direction =
            get_port_net_type_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, NetType::Reg);
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_ansi_module() {
        let ast = parse_verilog_string(
            "module alpha(input alpha,input wire beta, input reg gamma); endmodule",
        )
        .unwrap();
        let alpha_direction = get_port_net_type(
            "alpha",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        let beta_direction =
            get_port_net_type("beta", unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast)
                .unwrap();
        let gamma_direction = get_port_net_type(
            "gamma",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        assert_eq!(alpha_direction, NetType::Wire);
        assert_eq!(beta_direction, NetType::Wire);
        assert_eq!(gamma_direction, NetType::Reg);
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_nonansi_module() {
        let ast = parse_verilog_string(
            "module alpha(alpha,beta,gamma); input alpha; input wire beta; input reg gamma; endmodule",
        )
        .unwrap();
        let alpha_direction = get_port_net_type(
            "alpha",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        let beta_direction =
            get_port_net_type("beta", unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast)
                .unwrap();
        let gamma_direction = get_port_net_type(
            "gamma",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        assert_eq!(alpha_direction, NetType::Wire);
        assert_eq!(beta_direction, NetType::Wire);
        assert_eq!(gamma_direction, NetType::Reg);
    }
}
