use rust_hls::hls;

#[hls]
#[no_mangle]
pub fn addition(a: u32, b: u32) -> u32 {
    a + b
}

fn main() {
    let _adder = Addition::default();
}
