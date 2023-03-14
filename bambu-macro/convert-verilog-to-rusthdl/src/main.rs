use convert_verilog_to_rusthdl::{
    extract_module_interface::extract_module_interface,
    verilog_parser::{parse_verilog_file, parse_verilog_string},
};

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

pub fn main() {
    let result = parse_verilog_file("md5.v");
    let syntax_tree = result.unwrap();
    let ports = extract_module_interface(&syntax_tree, Some("md5"));
    println!("{:#?}", ports);
}