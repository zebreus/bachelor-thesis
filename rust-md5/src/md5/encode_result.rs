pub trait ToHashString {
    fn into_hash_string(self) -> String;
}
pub trait ToHashNumbers {
    fn into_hash_numbers(self) -> [u32; 4];
}

impl ToHashString for [u32; 4] {
    fn into_hash_string(self) -> String {
        let mut result = String::new();
        for byte in self.iter() {
            result.push_str(&format!("{:08x}", byte.to_be()));
        }
        result
    }
}

impl ToHashNumbers for &str {
    fn into_hash_numbers(self) -> [u32; 4] {
        let mut result = [0u32; 4];
        for i in 0..4 {
            result[i] = u32::from_str_radix(&self[i * 8..(i + 1) * 8], 16)
                .unwrap()
                .to_be();
        }
        result
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn encoding_result_works() {
        let result = "d41d8cd98f00b204e9800998ecf8427e".into_hash_numbers();

        assert_eq!(
            result,
            [
                0xd41d8cd9u32.to_be(),
                0x8f00b204u32.to_be(),
                0xe9800998u32.to_be(),
                0xecf8427eu32.to_be()
            ]
        );
    }

    #[test]
    fn decoding_result_works() {
        let result = [
            0xd41d8cd9u32.to_be(),
            0x8f00b204u32.to_be(),
            0xe9800998u32.to_be(),
            0xecf8427eu32.to_be(),
        ]
        .into_hash_string();

        assert_eq!(result, String::from("d41d8cd98f00b204e9800998ecf8427e"));
    }
}
