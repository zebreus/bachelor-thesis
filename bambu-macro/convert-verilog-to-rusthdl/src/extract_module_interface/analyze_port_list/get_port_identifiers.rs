use crate::extract_module_interface::get_identifier::get_identifier;

use itertools::Itertools;
use sv_parser::{RefNode, SyntaxTree};

pub fn get_port_identifiers(module: RefNode, ast: &SyntaxTree) -> Vec<String> {
    let port_identifiers = module.into_iter().filter_map(|node| match node {
        RefNode::PortIdentifier(_) => get_identifier(node, ast).map(String::from),
        _ => None,
    });
    port_identifiers.unique().collect_vec()
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
        let ports = get_port_identifiers(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 2);
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_nonansi_module() {
        let ast = parse_verilog_string(
            "module alpha(alpha,beta,gamma); input alpha; output beta; inout gamma; endmodule",
        )
        .unwrap();
        let ports = get_port_identifiers(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 3);
    }

    #[test]
    fn finding_the_directon_of_named_ports_works_with_ansi_module() {
        let ast =
            parse_verilog_string("module alpha(input alpha,output beta, inout gamma); endmodule")
                .unwrap();
        let ports = get_port_identifiers(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 3);
    }
}
