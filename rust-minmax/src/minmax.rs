/// Minmax function that is as similar as possible as the equivalent cpp function
pub unsafe extern "C" fn minmax(
    numbers: *mut i32,
    numbers_length: i32,
    out_max: &mut i32,
    out_min: &mut i32,
) {
    let mut local_max = *numbers.offset(0);
    let mut local_min = *numbers.offset(0);
    for i in 0..numbers_length {
        if *numbers.offset(i as isize) > local_max {
            local_max = *numbers.offset(i as isize);
        }
        if *numbers.offset(i as isize) < local_min {
            local_min = *numbers.offset(i as isize);
        }
    }
    *out_max = local_max;
    *out_min = local_min;
}

#[cfg(test)]
mod tests {

    use super::minmax;

    #[test]
    fn minmax_works_as_expected() {
        let mut numbers: [i32; 25] = [
            0x21258F79, 0x34D5CCF9, 0x3598261E, 0x7D154730, 0x5B284E05, 0x5F97A42D, 0x10FEE5A0,
            0x2C5BDA0C, 0x4D30A6F7, 0x30935AB7, 0x4B5AA93F, 0x49A6E626, 0x61A57C16, 0x43B831CD,
            0x01F22F1A, 0x05E5635A, 0x64BEFEF2, 0x61367095, 0x787C5A55, 0x3C3EE88A, 0x040C7922,
            0x1841F924, 0x16F53526, 0x75F644E9, 0x3AF1FF7B,
        ];
        let mut result_max = 0;
        let mut result_min = 0;
        unsafe {
            let input_pointer: *mut i32 = std::mem::transmute(&mut numbers);
            minmax(input_pointer, 25, &mut result_max, &mut result_min);
        }
        assert_eq!(result_max, 0x7D154730);
        assert_eq!(result_min, 0x01F22F1A);
    }
}
