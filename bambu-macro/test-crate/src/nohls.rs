use rust_hdl::prelude::*;
use std::fs;

#[derive(LogicBlock)]
struct Counter {
    pub clock: Signal<In, Clock>,
    pub led: Signal<Out, Bits<6>>,
    clock_counter: DFF<Bits<32>>,
    led_counter: DFF<Bits<6>>,
    delay: Constant<Bits<32>>,
}

impl Counter {
    // Create a new counter
    pub fn new(delay: u64) -> Self {
        Self {
            clock: Default::default(),
            led: Default::default(),
            clock_counter: Default::default(),
            led_counter: Default::default(),
            delay: Constant::new(delay.into()),
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

        if self.clock_counter.q.val() >= self.delay.val() - 1 {
            self.clock_counter.d.next = 0.into();
            self.led_counter.d.next = self.led_counter.q.val() + 1u64.to_bits();
        }
    }
}

/// Create a counter.v file
pub fn counter() {
    let mut device = Counter::new(13500000u64);
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./counter.v", data).expect("Unable to write file");
}
