use std::path::PathBuf;

use base64::{engine::general_purpose, Engine};
use merkle_hash::{Algorithm, MerkleTree};

use super::CachingError;

pub fn calculate_hash(path: &PathBuf) -> Result<String, CachingError> {
    let tree = MerkleTree::builder(&path.to_str().unwrap_or("shouldalwaysbeinvalid"))
        .algorithm(Algorithm::Blake3)
        .hash_names(false)
        .build()
        .or_else(|e| {
            Err(CachingError::FailedToCalculateHash {
                message: e.to_string(),
            })
        })?;
    let hash = general_purpose::STANDARD_NO_PAD
        .encode(&tree.root.item.hash)
        .replace("/", "_");

    Ok(hash)
}

#[cfg(test)]
mod tests {

    use std::path::Path;

    use super::*;

    #[test]
    fn caching_the_same_direcctory_twice_returns_the_same_hash() {
        let crate_path = Path::new("test_suites/extract_function_test");

        let hash1 = calculate_hash(&crate_path.to_path_buf()).unwrap();
        let hash2 = calculate_hash(&crate_path.to_path_buf()).unwrap();

        assert_eq!(hash1, hash2);
    }

    #[test]
    fn caching_two_different_direcctories_returns_different_hashes() {
        let crate_path1 = Path::new("test_suites/test_crate");
        let crate_path2 = Path::new("test_suites/extract_function_test");

        let hash1 = calculate_hash(&crate_path1.to_path_buf()).unwrap();
        let hash2 = calculate_hash(&crate_path2.to_path_buf()).unwrap();

        assert_ne!(hash1, hash2);
    }

    #[test]
    fn hashing_a_nonexistent_directory_returns_an_error() {
        let nonexistent_directory = Path::new("test_suites/sdfsadfadf");

        let hash1 = calculate_hash(&nonexistent_directory.to_path_buf());

        assert!(matches!(hash1, Err(_)));
    }
}
