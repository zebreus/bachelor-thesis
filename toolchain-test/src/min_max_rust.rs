/// Minmax function that is as similar as possible as the equivalent c function
///
/// ```cpp
/// void min_max(int* input, int num_elements, int* out_max, int* out_min)
/// {
///     int local_max = input[0];
///     int local_min = input[0];
///     int i = 0;
///     for(i = 0; i < num_elements; i++)
///     {
///        if(input[i] > local_max)
///        {
///           local_max = input[i];
///        }
///        if(input[i] < local_min)
///        {
///           local_min = input[i];
///        }
///     }
///     *out_max = local_max;
///     *out_min = local_min;
///  }
/// ```
///
/// Based on [bambu example](https://github.com/ferrandi/PandA-bambu/blob/main/documentation/tutorial_date_2022/bambu.ipynb)
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
