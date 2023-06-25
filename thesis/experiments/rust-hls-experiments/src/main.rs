mod keccak;
mod md5;
mod minmax;
pub mod test_macros;
use test_macros::{clear_reports, write_title_lines};

pub fn main() {
    clear_reports();
    write_title_lines();
    md5::run_experiments();
    keccak::run_experiments();
    minmax::run_experiments();
}
