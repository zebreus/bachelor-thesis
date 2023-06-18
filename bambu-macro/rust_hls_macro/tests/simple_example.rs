use rust_hls::hls;

#[hls]
pub mod adder_module {
    #[hls]
    pub extern "C" fn adder(a: u32, b: u32) -> u32 {
        a + b
    }
}

fn main() {
    let result = adder_module::adder(1, 2);
    assert_eq!(result, 3)
}
