// This test checks that a macro named wrap_verilog exists and that it can be used with the expected parameters

use rust_hdl::prelude::*;
use wrap_verilog_in_rust_hdl_macro::wrap_verilog;

wrap_verilog!(
    r#"
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
"#,
    "counter"
);

fn main() {
    Counter {
        clock: Signal::default(),
        led: Signal::new_with_default(3.into()),
    };
}
