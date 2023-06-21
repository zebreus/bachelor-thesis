#[hls]
pub mod hls_module {
    #[hls]
    #[no_mangle]
    pub fn add(left: usize, right: usize) -> usize {
        left + right
    }
}
