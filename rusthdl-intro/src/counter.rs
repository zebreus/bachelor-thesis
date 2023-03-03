use rust_hdl::docs::vcd2svg::vcd_to_svg;
use rust_hdl::prelude::*;
use std::fs;

/*
// tag::verilog-implementation[]
module top
    (
        input clk,
        output [5:0] led
    );

    reg [23:0] clockCounter = 0;
    localparam WAIT_TIME = 13500000;
    reg [5:0] ledCounter = 0;

    always @(posedge clk) begin
        clockCounter <= clockCounter + 1;
        if (clockCounter == WAIT_TIME) begin
            clockCounter <= 0;
            ledCounter <= ledCounter + 1;
        end
    end

    assign led = ~ledCounter;
endmodule
// end::verilog-implementation[]
 */

// tag::rust-hdl-implementation[]
// tag::rust-hdl-struct[]
#[derive(LogicBlock)]
struct Counter {
    pub clock: Signal<In, Clock>,
    pub led: Signal<Out, Bits<6>>,
    clock_counter: DFF<Bits<32>>,
    led_counter: DFF<Bits<6>>,
}
// end::rust-hdl-struct[]

const WAIT_TIME: u32 = 10;
impl Default for Counter {
    fn default() -> Self {
        Self {
            clock: Default::default(),
            led: Default::default(),
            clock_counter: Default::default(),
            led_counter: Default::default(),
        }
    }
}

impl Logic for Counter {
    #[hdl_gen]
    fn update(&mut self) {
        self.led_counter.clock.next = self.clock.val();
        self.clock_counter.clock.next = self.clock.val();
        self.led_counter.d.next = self.led_counter.q.val();

        self.led.next = self.led_counter.q.val();
        self.clock_counter.d.next = self.clock_counter.q.val() + 1u64.to_bits();

        if self.clock_counter.q.val() > WAIT_TIME.to_bits() {
            self.clock_counter.d.next = 0.into();
            self.led_counter.d.next = self.led_counter.q.val() + 1u64.to_bits();
        }
    }
}
// end::rust-hdl-implementation[]

pub fn simulate() {
    let mut sim = simple_sim!(Counter, clock, 10000, ep, {
        let mut x = ep.init()?;
        wait_clock_cycles!(ep, clock, x, 4 * 10000);
        ep.done(x)
    });

    let mut uut = Counter::default();
    uut.connect_all();

    sim.run_to_file(Box::new(uut), 5 * SIMULATION_TIME_ONE_SECOND, "counter.vcd")
        .unwrap();
}
pub fn generate() {
    let mut uut = Counter::default();
    uut.connect_all();
    let data = generate_verilog(&uut);
    fs::write("./counter.v", data).expect("Unable to write file");
}

pub fn counter() {
    generate();
    simulate();

    vcd_to_svg(
        "./counter.vcd",
        "./counter_all.svg",
        &["uut.clock", "uut.led"],
        0,
        4_000_000_000_000,
    )
    .unwrap();
    vcd_to_svg(
        "./counter.vcd",
        "./counter_pulse.svg",
        &["uut.clock", "uut.led"],
        900_000_000_000,
        1_500_000_000_000,
    )
    .unwrap();
}
