/// Minmax function that is as similar as possible as the equivalent cpp function
#[no_mangle]
pub unsafe extern "C" fn min_max_rust(
    input: *mut i32,
    num_elements: i32,
    out_max: &mut i32,
    out_min: &mut i32,
) {
    let mut local_max = *input.offset(0);
    let mut local_min = *input.offset(0);
    for i in 0..num_elements {
        if *input.offset(i as isize) > local_max {
            local_max = *input.offset(i as isize);
        }
        if *input.offset(i as isize) < local_min {
            local_min = *input.offset(i as isize);
        }
    }
    *out_max = local_max;
    *out_min = local_min;
}
