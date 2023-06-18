/// Nested modules should not be supported
use rust_hls::hls;

#[hls]
pub mod adder {
    #[hls]
    #[no_mangle]
    pub extern "C" fn adder(a: u32, b: u32) -> u32 {
        a + b
    }

    #[hls]
    pub mod other {
        #[hls]
        #[no_mangle]
        pub extern "C" fn other(a: u32, b: u32) -> u32 {
            a + b
        }
    }
}

fn main() {}
