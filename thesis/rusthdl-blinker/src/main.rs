use rust_hdl::prelude::*;
use std::fs;

mod blinker;

// tag::generate-verilog[]
use blinker::Blinker;

fn main() {
    let mut device = Blinker::new(10);
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./blinker.v", data).expect("Unable to write file");
}
// end::generate-verilog[]
