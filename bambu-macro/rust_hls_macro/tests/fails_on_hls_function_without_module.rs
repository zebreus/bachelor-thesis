use rust_hls::hls;

#[hls_main]
pub extern "C" fn adder(a: u32, b: u32) -> u32 {
    a + b
}

fn main() {}
