#[repr(C)]
pub struct MinMax {
    pub max: i32,
    pub min: i32,
}

#[no_mangle]
pub unsafe extern "C" fn min_max_rust_idiomatic(input: *mut i32, input_length: i32) -> MinMax {
    let slice = std::slice::from_raw_parts_mut(input, input_length as usize);

    slice.iter().fold(MinMax { max: 0, min: 0 }, |mut acc, &x| {
        if x > acc.max {
            acc.max = x;
        }
        if x < acc.min {
            acc.min = x;
        }
        acc
    })
}
