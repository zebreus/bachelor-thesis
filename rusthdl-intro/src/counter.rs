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

const WAIT_TIME: u64 = 1000;
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

        if self.clock_counter.q.val() >= WAIT_TIME.to_bits() - 1 {
            self.clock_counter.d.next = 0.into();
            self.led_counter.d.next = self.led_counter.q.val() + 1u64.to_bits();
        }
    }
}
// end::rust-hdl-implementation[]

/// Create a counter.v file
pub fn counter() {
    let mut device = Counter::default();
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./counter.v", data).expect("Unable to write file");
}

// tag::rust-hdl-test[]
#[cfg(test)]
mod tests {
    use super::Counter;
    use super::WAIT_TIME;
    use rust_hdl::prelude::*;

    #[test]
    fn should_be_able_to_count_to_ten() {
        // <1>
        let mut counter = Counter::default();
        counter.connect_all();

        // <2>
        let mut simulation = Simulation::new();
        let clock_period = 10000;
        simulation.add_clock(clock_period / 2, |counter: &mut Box<Counter>| {
            counter.clock.next = !counter.clock.val()
        });

        // <3>
        simulation.add_testbench(move |mut sim: Sim<Counter>| {
            let mut counter = sim.init()?;

            for expected_counter in 0..10 {
                sim_assert_eq!(sim, counter.led.val(), expected_counter, counter);
                wait_clock_cycles!(sim, clock, counter, WAIT_TIME)
            }

            sim.done(counter)
        });

        // <4>
        simulation
            .run_to_file(
                Box::new(counter),
                clock_period * WAIT_TIME * 20,
                &vcd_path!("should_be_able_to_count_to_ten.vcd"),
            )
            .unwrap();
    }
}
// end::rust-hdl-test[]
