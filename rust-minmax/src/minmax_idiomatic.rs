// tag::function[]
#[repr(C)]
pub struct MinMaxResult {
    pub max: i32,
    pub min: i32,
}

pub unsafe extern "C" fn minmax_idiomatic(
    numbers: *const i32,
    numbers_length: i32,
) -> MinMaxResult {
    let slice = std::slice::from_raw_parts(numbers, numbers_length as usize);

    slice.iter().fold(
        MinMaxResult {
            max: i32::MIN,
            min: i32::MAX,
        },
        |mut acc, &x| {
            if x > acc.max {
                acc.max = x;
            }
            if x < acc.min {
                acc.min = x;
            }
            acc
        },
    )
}
// end::function[]

#[cfg(test)]
mod tests {
    use super::minmax_idiomatic;

    #[test]
    fn minmax_works_as_expected() {
        let numbers: [i32; 25] = [
            0x21258F79, 0x34D5CCF9, 0x3598261E, 0x7D154730, 0x5B284E05, 0x5F97A42D, 0x10FEE5A0,
            0x2C5BDA0C, 0x4D30A6F7, 0x30935AB7, 0x4B5AA93F, 0x49A6E626, 0x61A57C16, 0x43B831CD,
            0x01F22F1A, 0x05E5635A, 0x64BEFEF2, 0x61367095, 0x787C5A55, 0x3C3EE88A, 0x040C7922,
            0x1841F924, 0x16F53526, 0x75F644E9, 0x3AF1FF7B,
        ];

        let result = unsafe { minmax_idiomatic(&numbers[0], 25) };

        assert_eq!(result.max, 0x7D154730);
        assert_eq!(result.min, 0x01F22F1A);
    }
}
