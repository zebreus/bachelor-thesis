// Unknown flags should result in an error

use rust_hls::hls;

#[hls(unknown_flag = "something")]
pub mod adder_module {
    #[hls]
    pub extern "C" fn adder(a: u32, b: u32) -> u32 {
        a + b
    }
}

fn main() {}
