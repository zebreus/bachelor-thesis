// Check that the rust_flags and the hls_flags arguments are supported

use rust_hls::hls;

#[hls(rust_flags = "")]
fn addition1(a: u32, b: u32) -> u32 {
    a + b
}

#[hls(hls_flags = "")]
fn addition2(a: u32, b: u32) -> u32 {
    a + b
}

#[hls(hls_flags = "", rust_flags = "")]
fn addition3(a: u32, b: u32) -> u32 {
    a + b
}

#[hls(rust_flags = "", hls_flags = "")]
fn addition4(a: u32, b: u32) -> u32 {
    a + b
}

fn main() {
    addition1(1, 2);
    addition2(1, 2);
    addition3(1, 2);
    addition4(1, 2);
}
