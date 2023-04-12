//! Functions for performing HLS from Rust
//!
//! This crate provides functions for performing HLS from Rust. It is intended to be used with the `rust_hls` crate which provides a macro using the functions in this crate.
//!
//! High-level synthesis is performed by ripping out a function an creating a new (temporary) crate that only exports that function.
//! A bash script containing the commands to synthesize the temporary crate is then created and executed.
//! The resulting Verilog is then returned as a string.

mod generate_hls_script;
mod rust_hls_options;

pub fn add(left: usize, right: usize) -> usize {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
