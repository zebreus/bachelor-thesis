use rust_hls::hls;

#[rust_hls::hls]
#[no_mangle]
pub fn synth_itoa(ass: u32) -> nalgebra::Matrix3<u32> {
    let matrix = nalgebra::Matrix3::<u32>::new(ass, ass, ass, 3, 2, 1, 2, 1, 2);
    return matrix;
    // match matrix.try_inverse() {
    //     Some(inv) => {
    //         println!("The inverse of m1 is: {}", inv);
    //     }
    //     None => {
    //         println!("m1 is not invertible!");
    //     }
    // }
}
