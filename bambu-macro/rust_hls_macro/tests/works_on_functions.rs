// Check that a hls attribute macro for functions exists

// Also asserts that the original function is still available after the macro is applied

use rust_hls::hls;

#[hls]
#[no_mangle]
pub fn addition(a: u32, b: u32) -> u32 {
    a + b
}

fn main() {
    let result = addition(1, 2);
    assert_eq!(result, 3)
}
