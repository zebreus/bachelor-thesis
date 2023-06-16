use std::{
    collections::hash_map::DefaultHasher,
    hash::{Hash, Hasher},
};

pub fn calculate_hash<U: Hash + Clone>(input: &Vec<U>) -> String {
    let mut s = DefaultHasher::new();
    input.hash(&mut s);
    let first_u64 = s.finish();
    let reverse_files: Vec<&U> = input.iter().rev().collect();
    reverse_files.hash(&mut s);
    let second_u64 = s.finish();

    let result = format!("{:x}{:x}", first_u64, second_u64);

    result
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn caching_the_same_direcctory_twice_returns_the_same_hash() {
        let files = vec!["alpha", "beta"];

        let hash1 = calculate_hash(&files);
        let hash2 = calculate_hash(&files);

        assert_eq!(hash1, hash2);
    }

    #[test]
    fn caching_two_different_direcctories_returns_different_hashes() {
        let files = vec!["alpha", "beta"];

        let files2 = vec!["alpha", "gamma"];

        let hash1 = calculate_hash(&files);
        let hash2 = calculate_hash(&files2);

        assert_ne!(hash1, hash2);
    }
}
