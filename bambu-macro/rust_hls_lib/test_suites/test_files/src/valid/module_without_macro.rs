pub mod not_hls_module {
    #[no_mangle]
    pub fn add(left: usize, right: usize) -> usize {
        left + right
    }
}
