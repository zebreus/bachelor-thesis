// Check that the rust_flags and the hls_flags arguments are supported
use rust_hls::hls;

#[hls(rust_flags = "")]
pub mod adder1 {
    #[hls]
    #[no_mangle]
    pub extern "C" fn addition1(a: u32, b: u32) -> u32 {
        a + b
    }
}

#[hls(hls_flags = "")]
pub mod adder2 {
    #[hls]
    #[no_mangle]
    pub extern "C" fn addition2(a: u32, b: u32) -> u32 {
        a + b
    }
}

#[hls(hls_flags = "", rust_flags = "")]
pub mod adder3 {
    #[hls]
    #[no_mangle]
    pub extern "C" fn addition3(a: u32, b: u32) -> u32 {
        a + b
    }
}

#[hls(rust_flags = "", hls_flags = "")]
pub mod adder4 {
    #[hls]
    #[no_mangle]
    pub extern "C" fn addition4(a: u32, b: u32) -> u32 {
        a + b
    }
}

fn main() {
    adder1::addition1(1, 2);
    adder2::addition2(1, 2);
    adder3::addition3(1, 2);
    adder4::addition4(1, 2);
}
