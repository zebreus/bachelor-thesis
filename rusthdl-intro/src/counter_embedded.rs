use rust_hdl::prelude::*;
use std::fs;

// tag::rust-hdl-implementation[]
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

#[derive(LogicBlock, Default)]
struct Counter {
    pub clock: Signal<In, Clock>,
    pub led: Signal<Out, Bits<6>>,
}

impl Logic for Counter {
    fn update(&mut self) {
        // <1>
    }
    fn connect(&mut self) {
        // <2>
        self.led.connect();
    }
    fn hdl(&self) -> Verilog {
        // <3>
        Verilog::Wrapper(Wrapper {
            code: "counter counter_inst(.clock(clock), .led(led));".into(),
            cores: VERILOG_COUNTER.into(),
        })
    }
}

// end::rust-hdl-implementation[]

/// Create a counter.v file
pub fn counter_embedded() {
    let mut device = Counter::default();
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./counter_embedded.v", data).expect("Unable to write file");
}
