enum PaddingState {
    ReadingData,
    Filling(u8),
    PrintingDataLength(u8),
    Done,
}

pub struct Md5PaddingIterator<A: Iterator<Item = u8>> {
    data_bytes: u64,
    state: PaddingState,
    first: A,
}
impl<A: Iterator<Item = u8>> Iterator for Md5PaddingIterator<A> {
    type Item = u8;
    fn next(&mut self) -> Option<Self::Item> {
        match self.state {
            PaddingState::ReadingData => {
                let next_data_byte = self.first.next();
                match next_data_byte {
                    Some(_) => {
                        self.data_bytes += 1;
                        next_data_byte
                    }
                    None => {
                        let data_bytes_and_stop_byte = self.data_bytes + 1;
                        let padding_size = ((64 + 56) - (data_bytes_and_stop_byte % 64)) % 64;
                        self.state = match padding_size {
                            0 => PaddingState::PrintingDataLength(8),
                            _ => PaddingState::Filling(padding_size as u8),
                        };
                        Some(0x80)
                    }
                }
            }
            PaddingState::Filling(remaining_length) => {
                self.state = match remaining_length {
                    1 => PaddingState::PrintingDataLength(8),
                    _ => PaddingState::Filling(remaining_length - 1),
                };
                Some(0)
            }
            PaddingState::PrintingDataLength(current_byte) => {
                self.state = match current_byte {
                    1 => PaddingState::Done,
                    _ => PaddingState::PrintingDataLength(current_byte - 1),
                };
                let length_as_bytes: [u8; 8] = (self.data_bytes * 8).to_le_bytes();
                Some(length_as_bytes[8 - current_byte as usize])
            }
            PaddingState::Done => None,
        }
    }
}
pub trait IteratorExt<A: Iterator<Item = u8>> {
    fn pad_md5_bytes(self) -> Md5PaddingIterator<A>;
    fn pad_md5_blocks(self) -> std::iter::ArrayChunks<Md5PaddingIterator<A>, 64>
    where
        Self: Sized,
    {
        let blocks_iter = self.pad_md5_bytes();
        let chunks = blocks_iter.array_chunks::<64>();
        return chunks;
    }
}
impl<A: Iterator<Item = u8>> IteratorExt<A> for A {
    fn pad_md5_bytes(self) -> Md5PaddingIterator<A> {
        Md5PaddingIterator {
            first: self,
            state: PaddingState::ReadingData,
            data_bytes: 0,
        }
    }
}
impl IteratorExt<std::vec::IntoIter<u8>> for String {
    fn pad_md5_bytes(self) -> Md5PaddingIterator<std::vec::IntoIter<u8>> {
        // todo!();
        let bytes_iterator = self.into_bytes().into_iter();
        Md5PaddingIterator {
            first: bytes_iterator,
            state: PaddingState::ReadingData,
            data_bytes: 0,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn padding_works_for_empty_input() {
        let mut correct = [0u8; 64];
        correct[0] = 0x80;

        let generated_bytes = [].into_iter().pad_md5_blocks().next().expect("No block");

        assert_eq!(generated_bytes, correct)
    }

    #[test]
    fn padding_works_for_single_byte() {
        let mut correct = [0u8; 64];
        correct[0] = 0x97;
        correct[1] = 0x80;
        correct[63 - 7] = 8;

        let generated_bytes = [0x97]
            .into_iter()
            .pad_md5_blocks()
            .next()
            .expect("No block");

        assert_eq!(generated_bytes, correct)
    }

    #[test]
    fn padding_returns_correct_length_for_empty_input() {
        let result = [].into_iter().pad_md5_bytes().collect::<Vec<u8>>();
        assert_eq!(result.len(), 64);
    }

    #[test]
    fn padding_returns_correct_length_for_single_value_input() {
        let result = [0x97].into_iter().pad_md5_bytes().collect::<Vec<u8>>();
        assert_eq!(result.len(), 64);
    }

    #[test]
    fn padding_returns_length_64_for_max_input_for_one_block() {
        let result = [0x97; 55].into_iter().pad_md5_bytes().collect::<Vec<u8>>();
        assert_eq!(result.len(), 64);
    }

    #[test]
    fn padding_returns_length_128_for_min_input_for_two_blocks() {
        let result = [0x97; 56].into_iter().pad_md5_bytes().collect::<Vec<u8>>();
        assert_eq!(result.len(), 128);
    }
}
