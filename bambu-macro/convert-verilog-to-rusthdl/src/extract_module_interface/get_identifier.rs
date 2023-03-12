use sv_parser::{unwrap_node, RefNode, SyntaxTree};

pub fn get_identifier<'a>(node: RefNode, ast: &'a SyntaxTree) -> Option<&'a str> {
    // unwrap_node! can take multiple types
    match unwrap_node!(node, SimpleIdentifier, EscapedIdentifier) {
        Some(RefNode::SimpleIdentifier(x)) => {
            let locate = x.nodes.0;
            let identifier: &'a str = ast.get_str(&locate).unwrap();
            return Some(identifier);
        }
        Some(RefNode::EscapedIdentifier(x)) => {
            let locate = x.nodes.0;
            let identifier: &'a str = ast.get_str(&locate).unwrap();
            return Some(identifier);
        }
        _ => None,
    }
}

#[cfg(test)]
mod tests {
    use sv_parser::Identifier;

    use crate::verilog_parser::parse_verilog_string;

    use super::*;

    #[test]
    fn should_get_identifier_of_module() {
        let ast = parse_verilog_string("module counter(input clock, output [5:0] led); endmodule")
            .unwrap();
        let identifier = get_identifier(ast.into_iter().next().unwrap(), &ast).unwrap();
        assert_eq!(identifier, "counter");
    }

    #[test]
    fn should_get_identifier_of_reg() {
        let ast = parse_verilog_string("reg toaster = 8;").unwrap();
        let identifier = get_identifier(ast.into_iter().next().unwrap(), &ast).unwrap();
        assert_eq!(identifier, "toaster");
    }

    #[test]
    fn should_return_none_without_identifier() {
        let ast = parse_verilog_string("// comment").unwrap();
        let identifier = get_identifier(ast.into_iter().next().unwrap(), &ast);
        assert_eq!(identifier, None);
    }
}
