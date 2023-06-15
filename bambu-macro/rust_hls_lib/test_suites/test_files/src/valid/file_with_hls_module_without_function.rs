#[hls]
pub mod hls_module {
    #[no_mangle]
    pub fn add(left: usize, right: usize) -> usize {
        left + right
    }
}
