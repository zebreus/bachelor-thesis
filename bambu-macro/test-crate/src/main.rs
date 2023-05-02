use rust_hdl::prelude::*;
use std::fs;

#[rust_hls::hls]
#[no_mangle]
pub unsafe fn hls_counter() -> u32 {
    static mut COUNTER: u32 = 0;
    static mut LED_COUNTER: u32 = 0;
    COUNTER = COUNTER + 1;
    if COUNTER == 10 {
        COUNTER = 0;
        LED_COUNTER = LED_COUNTER + 1;
    }
    if LED_COUNTER == 64 {
        LED_COUNTER = 0;
    }
    return LED_COUNTER;
}

#[derive(LogicBlock)]
struct Counter {
    pub clock: Signal<In, Clock>,
    pub led: Signal<Out, Bits<6>>,
    hls_counter: HlsCounter,
}

impl Counter {
    // Create a new counter
    pub fn new() -> Self {
        Self {
            clock: Default::default(),
            led: Default::default(),
            hls_counter: HlsCounter::default(),
        }
    }
}

impl Logic for Counter {
    #[hdl_gen]
    fn update(&mut self) {
        self.hls_counter.clk.next = self.clock.val();
        self.hls_counter.reset.next = true;
        self.hls_counter.start_port.next = true;
        self.led.next = bit_cast::<6, 32>(self.hls_counter.return_port.val());
    }
}

/// Create a counter.v file
pub fn main() {
    let mut device = Counter::new();
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./counter.v", data).expect("Unable to write file");
}
