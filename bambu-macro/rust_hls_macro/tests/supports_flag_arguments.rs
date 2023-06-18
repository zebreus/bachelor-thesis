// Check that the rust_flags and the hls_flags arguments are supported
use rust_hls::hls;

#[hls(rust_flags = "")]
pub mod adder1 {
    #[hls]
    pub extern "C" fn addition(a: u32, b: u32) -> u32 {
        a + b
    }
}

#[hls(hls_flags = "")]
pub mod adder2 {
    #[hls]
    pub extern "C" fn addition(a: u32, b: u32) -> u32 {
        a + b
    }
}

#[hls(hls_flags = "", rust_flags = "")]
pub mod adder3 {
    #[hls]
    pub extern "C" fn addition(a: u32, b: u32) -> u32 {
        a + b
    }
}

#[hls(rust_flags = "", hls_flags = "")]
pub mod adder4 {
    #[hls]
    pub extern "C" fn addition(a: u32, b: u32) -> u32 {
        a + b
    }
}

fn main() {
    adder1::addition(1, 2);
    adder2::addition(1, 2);
    adder3::addition(1, 2);
    adder4::addition(1, 2);
}
