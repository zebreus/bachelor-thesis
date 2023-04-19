// Check that the rust_flags and the hls_flags arguments are supported

use rust_hls::hls;

#[hls(weird_argument = "")]
fn addition1(a: u32, b: u32) -> u32 {
    a + b
}

fn main() {
    addition1(1, 2);
}
