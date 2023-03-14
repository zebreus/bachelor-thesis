use std::{collections::HashMap, path::PathBuf};
use sv_parser::{parse_sv_str, SyntaxTree};

pub fn parse_verilog_string(input: &str) -> Result<SyntaxTree, sv_parser::Error> {
    // The path of SystemVerilog source file
    let path = PathBuf::from(".");
    // The list of defined macros
    let defines = HashMap::new();
    // The list of include paths
    let includes: Vec<PathBuf> = Vec::new();

    // Parse
    let result = parse_sv_str(input, &path, &defines, &includes, false, false);
    // parse_sv(&path, &defines, &includes, false, false);

    match result {
        Ok((syntax_tree, _)) => Ok(syntax_tree),
        Err(e) => Err(e),
    }
}

#[cfg(test)]
mod tests {

    use super::*;

    use sv_parser::{unwrap_node, Locate, RefNode};

    const VERILOG_COUNTER: &str = r#"
    module counter
    (
        input clock,
        output [5:0] led
    );
    
    reg [23:0] clockCounter = 0;
    localparam WAIT_TIME = 1000;
    reg [5:0] ledCounter = 0;
    
    always @(posedge clock) begin
        clockCounter <= clockCounter + 1;
        if (clockCounter == WAIT_TIME) begin
            clockCounter <= 0;
            ledCounter <= ledCounter + 1;
        end
    end
    
    assign led = ~ledCounter;
    endmodule
    "#;

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

    fn assert_node_with_name_exists(syntax_tree: &SyntaxTree, name: &str) {
        let found_node = syntax_tree.into_iter().find(|node| {
            match node {
                RefNode::ModuleDeclarationNonansi(x) => {
                    // unwrap_node! gets the nearest ModuleIdentifier from x
                    let id = unwrap_node!(*x, ModuleIdentifier).unwrap();

                    let id = get_identifier(id).unwrap();

                    // Original string can be got by SyntaxTree::get_str(self, locate: &Locate)
                    let id = syntax_tree.get_str(&id).unwrap();
                    if id != name {
                        return false;
                    }
                    return true;
                }
                RefNode::ModuleDeclarationAnsi(x) => {
                    let id = unwrap_node!(*x, ModuleIdentifier).unwrap();
                    let id = get_identifier(id).unwrap();
                    let id = syntax_tree.get_str(&id).unwrap();
                    if id != name {
                        return false;
                    }
                    return true;
                }
                _ => return false,
            }
        });
        if found_node.is_none() {
            panic!("Node with name {} not found", name);
        }
    }

    #[test]
    fn parsed_string_should_have_correct_module() {
        let result = parse_verilog_string(VERILOG_COUNTER);
        let syntax_tree = result.unwrap();
        assert_node_with_name_exists(&syntax_tree, "counter");
    }

    // #[test]
    // fn converting_back_to_string_works() {
    //     let result = parse_verilog_string(VERILOG_COUNTER);
    //     let syntax_tree = result.unwrap();
    //     let verilog = syntax_tree.get_str(syntax_tree.).unwrap();
    //     assert_eq!(verilog, VERILOG_COUNTER);
    // }

    #[test]
    fn parsing_test() {}
}
