use sv_parser::{unwrap_node, RefNode, SyntaxTree};

pub fn get_constant_number(node: RefNode, ast: &SyntaxTree) -> Option<i64> {
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
                    Some(i64::from_str_radix(unsigned_value, 10).unwrap())
                }
                Some(RefNode::OctalNumber(octal_number)) => {
                    let octal_value_node = &octal_number.nodes.2;
                    let locate = octal_value_node.nodes.0;
                    let octal_value = ast.get_str(&locate).unwrap();
                    Some(i64::from_str_radix(octal_value, 8).unwrap())
                }
                Some(RefNode::BinaryNumber(binary_number)) => {
                    let binary_value_node = &binary_number.nodes.2;
                    let locate = binary_value_node.nodes.0;
                    let binary_value = ast.get_str(&locate).unwrap();
                    Some(i64::from_str_radix(binary_value, 2).unwrap())
                }
                Some(RefNode::HexNumber(hex_number)) => {
                    let hex_value_node = &hex_number.nodes.2;
                    let locate = hex_value_node.nodes.0;
                    let hex_value = ast.get_str(&locate).unwrap();
                    Some(i64::from_str_radix(hex_value, 16).unwrap())
                }
                _ => panic!("Should not happen"),
            }
        }

        Some(RefNode::RealNumber(_x)) => {
            panic!("RealNumber not supported yet")
        }
        _ => None,
    };
    value
}

#[cfg(test)]
mod tests {
    use crate::verilog_parser::parse_verilog_string;

    use super::*;

    #[test]
    fn should_return_first_number_constant() {
        let result =
            parse_verilog_string("module counter(input clock, output [5:0] led); endmodule");
        let syntax_tree = result.unwrap();
        let number =
            get_constant_number(syntax_tree.into_iter().next().unwrap(), &syntax_tree).unwrap();
        assert_eq!(number, 5);
    }

    #[test]
    fn works_with_hex_numbers() {
        let result = parse_verilog_string("reg a = 64'h0F;");
        let syntax_tree = result.unwrap();
        let number =
            get_constant_number(syntax_tree.into_iter().next().unwrap(), &syntax_tree).unwrap();
        assert_eq!(number, 0xf);
    }

    #[test]
    fn works_with_octal_numbers() {
        let result = parse_verilog_string("reg a = 64'o07;");
        let syntax_tree = result.unwrap();
        let number =
            get_constant_number(syntax_tree.into_iter().next().unwrap(), &syntax_tree).unwrap();
        assert_eq!(number, 7);
    }

    #[test]
    fn works_with_binary_numbers() {
        let result = parse_verilog_string("reg a = 64'b11010;");
        let syntax_tree = result.unwrap();
        let number =
            get_constant_number(syntax_tree.into_iter().next().unwrap(), &syntax_tree).unwrap();
        assert_eq!(number, 0b11010);
    }

    #[test]
    fn works_without_number() {
        let result = parse_verilog_string("reg a;");
        let syntax_tree = result.unwrap();
        let number = get_constant_number(syntax_tree.into_iter().next().unwrap(), &syntax_tree);
        assert_eq!(number, None);
    }
}
