use std::{
    collections::hash_map::DefaultHasher,
    hash::{Hash, Hasher},
    path::PathBuf,
};

use super::CachingError;

pub fn calculate_hash<U: Hash + Clone>(files: &Vec<U>) -> Result<String, CachingError> {
    let mut s = DefaultHasher::new();
    files.hash(&mut s);
    let first_u64 = s.finish();
    let reverse_files: Vec<&U> = files.iter().rev().collect();
    reverse_files.hash(&mut s);
    let second_u64 = s.finish();

    let result = format!("{:x}{:x}", first_u64, second_u64);

    Ok(result)
}

#[cfg(test)]
mod tests {

    use std::path::Path;

    use crate::rust_hls::CrateFile;

    use super::*;

    #[test]
    fn caching_the_same_direcctory_twice_returns_the_same_hash() {
        let files = vec!["alpha", "beta"];

        let hash1 = calculate_hash(&files).unwrap();
        let hash2 = calculate_hash(&files).unwrap();

        assert_eq!(hash1, hash2);
    }

    #[test]
    fn caching_two_different_direcctories_returns_different_hashes() {
        let files = vec!["alpha", "beta"];

        let files2 = vec!["alpha", "gamma"];

        let hash1 = calculate_hash(&files).unwrap();
        let hash2 = calculate_hash(&files2).unwrap();

        assert_ne!(hash1, hash2);
    }
}
