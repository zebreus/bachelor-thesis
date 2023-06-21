#[hls]
pub mod hls_module_a {
    #[hls]
    #[no_mangle]
    pub fn add(left: usize, right: usize) -> usize {
        left + right
    }
}

#[hls]
pub mod hls_module_b {
    #[hls]
    #[no_mangle]
    pub fn add_a(left: usize, right: usize) -> usize {
        left + right
    }
}
