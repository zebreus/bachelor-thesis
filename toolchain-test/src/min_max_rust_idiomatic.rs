#[repr(C)]
pub struct MinMax {
    pub max: i32,
    pub min: i32,
}

#[no_mangle]
pub unsafe extern "C" fn min_max_rust_idiomatic(input: *mut i32, num_elements: i32) -> MinMax {
    let slice = std::slice::from_raw_parts_mut(input, num_elements as usize);

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
