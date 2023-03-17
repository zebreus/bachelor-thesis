use crate::extract_verilog_interface::{
    get_constant_number::get_constant_number, get_identifier::get_identifier,
};

use sv_parser::{unwrap_node, RefNode, SyntaxTree};

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum DataSize {
    Bit,
    Bits(u32),
}

pub fn get_port_data_size_ansi(port_declaration: RefNode, ast: &SyntaxTree) -> Option<DataSize> {
    let constant_range = unwrap_node!(port_declaration, ConstantRange);
    let data_size = match constant_range {
        Some(RefNode::ConstantRange(constant_range)) => {
            let start = get_constant_number((&constant_range.nodes.2).into(), ast)
                .expect("Failed to parse number");
            let end = get_constant_number((&constant_range.nodes.0).into(), ast)
                .expect("Failed to parse number");
            let length = u32::try_from(end.abs_diff(start) + 1);
            length.ok().map(|length| DataSize::Bits(length))
        }
        _ => Some(DataSize::Bit),
    };
    data_size
}

pub fn get_port_data_size(port_name: &str, module: RefNode, ast: &SyntaxTree) -> Option<DataSize> {
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

            get_port_data_size_ansi(ansi_declaration_net, &ast)
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
                matching_port_declarations.fold(DataSize::Bit, |acc, port_declaration| {
                    let port_data_size =
                        get_port_data_size_ansi(port_declaration.into(), &ast).unwrap();
                    match port_data_size {
                        DataSize::Bits(_) => port_data_size,
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
    fn works_with_ansi_without_range() {
        let ast = parse_verilog_string("module alpha(input clock); endmodule").unwrap();
        let port_direction =
            get_port_data_size_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, DataSize::Bit);
    }

    #[test]
    fn works_with_ansi_with_range() {
        let ast = parse_verilog_string("module alpha(input [7:0] clock); endmodule").unwrap();
        let port_direction =
            get_port_data_size_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, DataSize::Bits(8));
    }

    #[test]
    fn works_with_nonansi_without_range() {
        let ast = parse_verilog_string("module alpha(clock); input clock; endmodule").unwrap();
        println!("{:#?}", ast);
        let port_direction =
            get_port_data_size_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, DataSize::Bit);
    }

    #[test]
    fn works_with_nonansi_with_range() {
        let ast =
            parse_verilog_string("module alpha(clock); input [7:0] clock; endmodule").unwrap();
        let port_direction =
            get_port_data_size_ansi(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast).unwrap();
        assert_eq!(port_direction, DataSize::Bits(8));
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_nonansi_module() {
        let ast = parse_verilog_string(
            "module alpha(alpha,beta,gamma); input alpha; input [7:0] beta; input [0:0] gamma; endmodule",
        )
        .unwrap();
        let alpha_direction = get_port_data_size(
            "alpha",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        let beta_direction =
            get_port_data_size("beta", unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast)
                .unwrap();
        let gamma_direction = get_port_data_size(
            "gamma",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        assert_eq!(alpha_direction, DataSize::Bit);
        assert_eq!(beta_direction, DataSize::Bits(8));
        assert_eq!(gamma_direction, DataSize::Bits(1));
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_ansi_module() {
        let ast = parse_verilog_string(
            "module alpha(input alpha,input [7:0] beta,input [0:0] gamma); endmodule",
        )
        .unwrap();
        let alpha_direction = get_port_data_size(
            "alpha",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        let beta_direction =
            get_port_data_size("beta", unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast)
                .unwrap();
        let gamma_direction = get_port_data_size(
            "gamma",
            unwrap_node!(&ast, ModuleDeclaration).unwrap(),
            &ast,
        )
        .unwrap();
        assert_eq!(alpha_direction, DataSize::Bit);
        assert_eq!(beta_direction, DataSize::Bits(8));
        assert_eq!(gamma_direction, DataSize::Bits(1));
    }
}
