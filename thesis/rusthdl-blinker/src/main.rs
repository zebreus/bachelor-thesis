use rust_hdl::prelude::*;
use std::fs;

mod blinker;

use blinker::Blinker;

fn main() {
    let mut device = Blinker::new(13500000u64);
    device.connect_all();
    let data = generate_verilog(&device);
    fs::write("./blinker.v", data).expect("Unable to write file");
}
