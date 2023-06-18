/// There can only be one HLS function per module
use rust_hls::hls;

#[hls]
pub mod adder {
    #[hls]
    pub extern "C" fn adder(a: u32, b: u32) -> u32 {
        a + b
    }

    #[hls]
    pub extern "C" fn adderTwo(a: u32, b: u32) -> u32 {
        a + b
    }
}

fn main() {}
