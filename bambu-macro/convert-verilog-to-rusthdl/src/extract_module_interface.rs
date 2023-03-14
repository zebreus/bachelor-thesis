mod analyze_port_list;
mod find_module_by_name;
mod get_constant_number;
mod get_identifier;

use find_module_by_name::find_module_by_name;
use get_identifier::get_identifier;
use sv_parser::{unwrap_node, SyntaxTree};

use self::analyze_port_list::analyze_port_list;

pub use self::analyze_port_list::DataSize;
pub use self::analyze_port_list::Direction;
pub use self::analyze_port_list::NetType;
pub use self::analyze_port_list::Port;

pub fn extract_module_interface(ast: &SyntaxTree, module_name: Option<&str>) -> Vec<Port> {
    let module_name = module_name.unwrap_or(
        unwrap_node!(ast, ModuleIdentifier)
            .and_then(|x| get_identifier(x, ast))
            .expect("Failed to find a top level name"),
    );

    let module = find_module_by_name(module_name, ast.into_iter().next().unwrap(), &ast)
        .expect("Failed to find the top level module");
    analyze_port_list(module, ast)
}

#[cfg(test)]
mod tests {
    use sv_parser::unwrap_node;

    use crate::verilog_parser::parse_verilog_string;

    use super::*;

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

    #[test]
    fn can_extract_the_interface_of_counter() {
        let ast = parse_verilog_string(VERILOG_COUNTER).unwrap();
        let ports = analyze_port_list(unwrap_node!(&ast, ModuleDeclaration).unwrap(), &ast);
        assert_eq!(ports.len(), 2);
        assert_eq!(
            ports[0],
            Port {
                identifier: "clock".to_string(),
                direction: Direction::In,
                data_size: DataSize::Bit,
                net_type: NetType::Wire,
            }
        );
        assert_eq!(
            ports[1],
            Port {
                identifier: "led".to_string(),
                direction: Direction::Out,
                data_size: DataSize::Bits(6),
                net_type: NetType::Wire,
            }
        );
    }
}
