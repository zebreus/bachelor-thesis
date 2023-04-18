use std::{fs::create_dir_all, path::PathBuf};

use directories::ProjectDirs;

use super::CachingError;

/// Get a directory that can be used as a persistent cache
pub fn get_cache_path() -> Result<PathBuf, CachingError> {
    let cache_dir = ProjectDirs::from("org", "zebreus", "rust-hls")
        .and_then(|x| Some(x.cache_dir().to_path_buf()));
    if let Some(cache_dir) = cache_dir {
        create_dir_all(&cache_dir).unwrap_or(());
        return Ok(cache_dir);
    }

    let alternative_cache_dir = PathBuf::from("/tmp/rust-hls-cache");
    create_dir_all(&alternative_cache_dir).unwrap_or(());
    if alternative_cache_dir.exists() {
        return Ok(alternative_cache_dir);
    }

    Err(CachingError::NoValidCacheDirectoryFound)
}

/// Generates a path for the given hash in the cache directory.
pub fn generate_cached_path(hash: &str) -> Result<PathBuf, CachingError> {
    let cache_dir = get_cache_path()?;
    let cached_path = cache_dir.join(hash);

    return Ok(cached_path);
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn get_cache_path_works() {
        let cache_path = get_cache_path().unwrap();
        assert!(cache_path.exists());
    }

    #[test]
    fn generate_cached_path_works() {
        let hash = "test_hash";
        let cache_path = generate_cached_path(hash).unwrap();
        assert!(cache_path.exists());
        assert!(cache_path.to_str().unwrap().contains("test_hash"))
    }
}
