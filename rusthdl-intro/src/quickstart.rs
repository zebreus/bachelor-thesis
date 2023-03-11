use rust_hdl::prelude::*;
use std::fs;
use std::time::Duration;

// tag::blinky-implementation[]
#[derive(LogicBlock)] // <- This turns the struct into something you can simulate/synthesize
struct Blinky {
    pub clock: Signal<In, Clock>, // <- input signal, type is clock
    pulser: Pulser,               // <- sub-circuit, a widget that generates pulses
    pub led: Signal<Out, Bit>,    // <- output signal, type is single bit
}

const CLOCK_SPEED_HZ: u64 = 10_000;
impl Default for Blinky {
    fn default() -> Self {
        Self {
            clock: Default::default(),
            pulser: Pulser::new(CLOCK_SPEED_HZ, 1.0, Duration::from_millis(250)),
            led: Default::default(),
        }
    }
}

impl Logic for Blinky {
    #[hdl_gen] // <- this turns the update function into an HDL Kernel that can be turned into Verilog
    fn update(&mut self) {
        // v-- write to the .next member     v-- read from .val() method
        self.pulser.clock.next = self.clock.val();
        self.pulser.enable.next = true.into();
        self.led.next = self.pulser.pulse.val();
    }
}
// end::blinky-implementation[]

// tag::simulate-blinky[]
pub fn simulate_blinky() {
    // v--- build a simple simulation (1 testbench, single clock)
    let mut sim = simple_sim!(Blinky, clock, CLOCK_SPEED_HZ, ep, {
        let mut x = ep.init()?;
        wait_clock_cycles!(ep, clock, x, 4 * CLOCK_SPEED_HZ);
        ep.done(x)
    });

    // v--- construct the circuit
    let mut uut = Blinky::default();
    uut.connect_all();

    // v--- run the simulation
    sim.run_to_file(Box::new(uut), 5 * SIMULATION_TIME_ONE_SECOND, "blinky.vcd")
        .unwrap();
}
// end::simulate-blinky[]

// tag::generate-verilog[]
pub fn generate_blinky() {
    let mut uut = Blinky::default();
    uut.connect_all();
    let data = generate_verilog(&uut);
    fs::write("./blinky.v", data).expect("Unable to write file");
}
// end::generate-verilog[]

// pub fn quickstart() {
//     generate();
//     simulate();

//     vcd_to_svg(
//         "./blinky.vcd",
//         "./blinky_all.svg",
//         &["uut.clock", "uut.led"],
//         0,
//         4_000_000_000_000,
//     )
//     .unwrap();
//     vcd_to_svg(
//         "./blinky.vcd",
//         "./blinky_pulse.svg",
//         &["uut.clock", "uut.led"],
//         900_000_000_000,
//         1_500_000_000_000,
//     )
//     .unwrap();
// }
