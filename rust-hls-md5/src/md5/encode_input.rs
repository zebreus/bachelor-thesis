trait ToMd5Numbers {
    fn into_md5_numbers(self) -> [u32; 16];
}
trait ToMd5Bytes {
    fn into_md5_bytes(self) -> [u8; 64];
}

impl ToMd5Numbers for [u8; 64] {
    fn into_md5_numbers(self) -> [u32; 16] {
        let mut result = [0u32; 16];
        for word in 0..16 {
            result[word] = u32::from_le_bytes([
                self[word * 4],
                self[word * 4 + 1],
                self[word * 4 + 2],
                self[word * 4 + 3],
            ]);
        }
        result
    }
}

impl ToMd5Bytes for [u32; 16] {
    fn into_md5_bytes(self) -> [u8; 64] {
        let result: [u8; 64] = self
            .into_iter()
            .map(|x| x.to_le_bytes())
            .flatten()
            .collect::<Vec<u8>>()
            .try_into()
            .expect("Failed to collect into array. Should never happen.");
        result
    }
}

#[cfg(test)]
pub fn first_md5_block(input: &[u8]) -> [u32; 16] {
    use super::padding::IteratorExt;

    let a = input.to_owned();
    a.into_iter()
        .pad_md5_blocks()
        .next()
        .expect("No block")
        .into_md5_numbers()
}

#[cfg(test)]
mod tests {
    use crate::md5::padding::IteratorExt;

    use super::*;

    #[test]
    fn encoding_empty_input_works() {
        // let input = pad_and_fill(String::from("a"));
        let mut correct = [0u32; 16];
        correct[0] = u32::from_le_bytes([0x80, 0, 0, 0]);

        let generated_bytes = [].into_iter().pad_md5_blocks().next().expect("No block");

        let generated = generated_bytes.into_md5_numbers();

        assert_eq!(generated, correct)
    }

    #[test]
    fn encoding_single_value_input_works() {
        // let input = pad_and_fill(String::from("a"));
        let mut correct = [0u32; 16];
        correct[0] = u32::from_le_bytes([0x97, 0x80, 0, 0]);
        correct[14] = u32::from_le_bytes([0x08, 0, 0, 0]);

        let generated_bytes = [0x97]
            .into_iter()
            .pad_md5_blocks()
            .next()
            .expect("No block");

        let generated = generated_bytes.into_md5_numbers();

        assert_eq!(generated, correct)
    }
}
