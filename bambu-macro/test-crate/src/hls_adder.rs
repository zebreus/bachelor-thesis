use rust_hdl::prelude::*;
use std::fs;
use wrap_verilog_in_rust_hdl_macro::wrap_verilog;

#[rust_hls::hls]
#[no_mangle]
pub fn adder(a: u32, b: u32) -> u32 {
    // Eyydys
    a + b
}

#[derive(LogicBlock)]
struct Counter {
    pub clock: Signal<In, Clock>,
    pub led: Signal<Out, Bits<6>>,
    clock_counter: DFF<Bits<32>>,
    led_counter: DFF<Bits<6>>,
    delay: Constant<Bits<32>>,
    adder: Adder,
}
// end::rust-hdl-struct[]

impl Counter {
    // Create a new counter
    pub fn new(delay: u64) -> Self {
        Self {
            clock: Default::default(),
            led: Default::default(),
            clock_counter: Default::default(),
            led_counter: Default::default(),
            delay: Constant::new(delay.into()),
            adder: Adder::default(),
            // adder:Adder::
        }
    }
}

impl Logic for Counter {
    #[hdl_gen]
    fn update(&mut self) {
        self.led_counter.clock.next = self.clock.val();
        self.clock_counter.clock.next = self.clock.val();
        self.led_counter.d.next = self.led_counter.q.val();
        self.adder.clk.next = self.clock.val();
        self.adder.reset.next = true;
        self.adder.start_port.next = false;

        self.adder.pd5.next = self.clock_counter.q.val();
        self.adder.pd6.next = 1u64.to_bits();
        self.clock_counter.d.next = self.adder.return_port.val();

        self.led.next = self.led_counter.q.val();
        if self.clock_counter.q.val() >= self.delay.val() - 1 {
            self.clock_counter.d.next = 0.into();
            self.led_counter.d.next = self.led_counter.q.val() + 1u64.to_bits();
        }
    }
}
// end::rust-hdl-implementation[]

/// Create a counter.v file
pub fn main() {
    let mut device = Counter::new(100u64);
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./counter.v", data).expect("Unable to write file");
}
