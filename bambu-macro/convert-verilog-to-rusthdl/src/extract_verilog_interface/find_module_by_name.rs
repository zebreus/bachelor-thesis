use super::get_identifier::get_identifier;
use sv_parser::{unwrap_node, RefNode, SyntaxTree};

pub fn find_module_by_name<'a>(
    name: &str,
    node: RefNode<'a>,
    ast: &'a SyntaxTree,
) -> Option<RefNode<'a>> {
    let thing = node.into_iter().find(|node| {
        match node {
            RefNode::ModuleDeclarationNonansi(x) => {
                // unwrap_node! gets the nearest ModuleIdentifier from x
                let id = unwrap_node!(*x, ModuleIdentifier).unwrap();

                let id = get_identifier(id, ast).unwrap();
                if id != name {
                    return false;
                }
                return true;
            }
            RefNode::ModuleDeclarationAnsi(x) => {
                let id = unwrap_node!(*x, ModuleIdentifier).unwrap();
                let id = get_identifier(id, ast).unwrap();
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

#[cfg(test)]
mod tests {
    use crate::verilog_parser::parse_verilog_string;

    use super::*;

    #[test]
    fn should_work_with_a_single_module() {
        let ast =
            parse_verilog_string("module alpha(input clock, output [5:0] led); endmodule").unwrap();
        let module = find_module_by_name("alpha", ast.into_iter().next().unwrap(), &ast).unwrap();
        let identifier = get_identifier(module, &ast).unwrap();
        assert_eq!(identifier, "alpha");
    }

    #[test]
    fn should_return_none_if_module_does_not_exist() {
        let ast =
            parse_verilog_string("module alpha(input clock, output [5:0] led); endmodule").unwrap();
        let module = find_module_by_name("beta", ast.into_iter().next().unwrap(), &ast);
        assert_eq!(module, None);
    }

    #[test]
    fn should_be_able_to_find_a_module_surrounded_by_other_modules() {
        let ast =
            parse_verilog_string("module alpha(input clock, output [5:0] led); endmodule; module beta(input clock, output [5:0] led); endmodule;  module gamma(input clock, output [5:0] led); endmodule").unwrap();
        let module = find_module_by_name("beta", ast.into_iter().next().unwrap(), &ast).unwrap();
        let identifier = get_identifier(module, &ast).unwrap();
        assert_eq!(identifier, "beta");
    }
}
