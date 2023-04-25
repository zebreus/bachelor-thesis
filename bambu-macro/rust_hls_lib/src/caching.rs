mod calculate_hash;
mod generate_cached_path;
use fs_extra::dir::{copy, CopyOptions};
use rand::{distributions::Alphanumeric, thread_rng, Rng};
use std::{fs, io, path::PathBuf};

use thiserror::Error;

pub use generate_cached_path::get_cache_path;

#[derive(Error, Debug)]
pub enum CachingError {
    #[error("Failed to calculate hash: {message}")]
    FailedToCalculateHash { message: String },
    #[error("Failed to find cache directory")]
    NoValidCacheDirectoryFound,
    #[error(transparent)]
    IoError(#[from] io::Error),
    #[error(transparent)]
    FsExtraError(#[from] fs_extra::error::Error),
}

#[derive(Clone, Debug, PartialEq)]
pub enum CachePath {
    Cached {
        path: PathBuf,
    },
    Uncached {
        working_path: PathBuf,
        final_path: PathBuf,
    },
}

impl CachePath {
    pub fn finalize(self) -> Result<CachePath, CachingError> {
        match self {
            CachePath::Cached { .. } => Ok(self),
            CachePath::Uncached {
                working_path,
                final_path,
            } => {
                if final_path.exists() {
                    // fs::remove_dir_all(&working_path).unwrap_or(());
                    Ok(CachePath::Cached { path: final_path })
                } else {
                    fs::create_dir_all(&final_path)?;
                    copy(
                        &working_path,
                        &final_path,
                        &CopyOptions::new().copy_inside(true).content_only(true),
                    )?;
                    Ok(CachePath::Cached { path: final_path })
                }
            }
        }
    }

    /// Get a new CachePath representing the current state
    pub fn update(self) -> Result<CachePath, CachingError> {
        match self {
            CachePath::Cached { .. } => Ok(self),
            CachePath::Uncached {
                working_path,
                final_path,
            } => {
                if final_path.exists() {
                    Ok(CachePath::Cached { path: final_path })
                } else {
                    Ok(CachePath::Uncached {
                        working_path,
                        final_path,
                    })
                }
            }
        }
    }

    pub fn new(based_on: PathBuf) -> Result<CachePath, CachingError> {
        let hash = calculate_hash::calculate_hash(&based_on)?;
        let ready_cache_path = generate_cached_path::generate_cached_path(&hash).unwrap();
        if ready_cache_path.exists() {
            Ok(CachePath::Cached {
                path: ready_cache_path,
            })
        } else {
            let working_cache_id: String = thread_rng()
                .sample_iter(&Alphanumeric)
                .take(10)
                .map(char::from)
                .collect();
            let working_cache_path = generate_cached_path::generate_cached_path(
                format!("{}-{}", hash, working_cache_id).as_str(),
            )?;
            fs::create_dir_all(&working_cache_path)?;
            copy(
                &based_on,
                &working_cache_path,
                &CopyOptions::new().copy_inside(true).content_only(true),
            )?;

            Ok(CachePath::Uncached {
                working_path: working_cache_path,
                final_path: ready_cache_path,
            })
        }
    }
}

// get_cache_path Cached, Uncached

#[cfg(test)]
mod tests {

    use std::{fs::File, io::Write};

    use tempfile::TempDir;

    use super::*;

    fn write_random_file(path: &PathBuf) -> io::Result<()> {
        let content: String = thread_rng()
            .sample_iter(&Alphanumeric)
            .take(100)
            .map(char::from)
            .collect();

        let mut file = File::create(path)?;

        file.write_all(content.as_bytes())?;
        file.sync_all()?;

        Ok(())
    }

    #[test]
    fn unknown_input_results_in_unchached_variant() {
        let dir = TempDir::new().unwrap();
        let path = dir.path().to_path_buf();

        write_random_file(&path.join("test.txt")).unwrap();

        let cache_path = CachePath::new(path).unwrap();

        match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { .. } => {}
        }
    }

    #[test]
    fn new_cache_path_does_not_remove_base_directory() {
        let dir = TempDir::new().unwrap();
        let path = dir.path().to_path_buf();

        write_random_file(&path.join("test.txt")).unwrap();

        let cache_path = CachePath::new(path.clone()).unwrap();

        let working_path = match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { working_path, .. } => working_path,
        };

        assert!(path.exists());
        assert!(working_path.exists());
    }

    #[test]
    fn same_input_twice_without_finalizing_results_in_two_unchached_variants_with_same_final_path()
    {
        let random_content: String = thread_rng()
            .sample_iter(&Alphanumeric)
            .take(100)
            .map(char::from)
            .collect();

        let dir = TempDir::new().unwrap();
        let path = dir.path().to_path_buf();

        File::create(&path.join("test.txt"))
            .unwrap()
            .write_all(random_content.as_bytes())
            .unwrap();

        let cache_path = CachePath::new(path.clone()).unwrap();

        let final_path1 = match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { final_path, .. } => final_path,
        };

        let cache_path = CachePath::new(path).unwrap();

        let final_path2 = match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { final_path, .. } => final_path,
        };

        assert_eq!(final_path1, final_path2);
    }

    #[test]
    fn same_input_twice_in_different_directories_is_treated_as_the_same() {
        let random_content: String = thread_rng()
            .sample_iter(&Alphanumeric)
            .take(100)
            .map(char::from)
            .collect();

        let dir = TempDir::new().unwrap();
        let path = dir.path().to_path_buf();

        File::create(&path.join("test.txt"))
            .unwrap()
            .write_all(random_content.as_bytes())
            .unwrap();

        let cache_path = CachePath::new(path).unwrap();

        let final_path1 = match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { final_path, .. } => final_path,
        };

        let dir2 = TempDir::new().unwrap();
        let path2 = dir2.path().to_path_buf();

        File::create(&path2.join("test.txt"))
            .unwrap()
            .write_all(random_content.as_bytes())
            .unwrap();

        let cache_path2 = CachePath::new(path2).unwrap();

        let final_path2 = match cache_path2 {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { final_path, .. } => final_path,
        };

        assert_eq!(final_path1, final_path2);
    }

    #[test]
    fn finalize_returns_a_cached_path() {
        let dir = TempDir::new().unwrap();
        let path = dir.path().to_path_buf();

        write_random_file(&path.join("test.txt")).unwrap();

        let cache_path = CachePath::new(path.clone()).unwrap();

        let final_path = match &cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { final_path, .. } => final_path,
        }
        .clone();

        let cache_path = cache_path.finalize().unwrap();

        let real_final_path = match cache_path {
            CachePath::Cached { path } => path,
            CachePath::Uncached { .. } => panic!("Expected cached variant"),
        };

        assert_eq!(final_path, real_final_path);
    }

    #[test]
    fn new_creates_cached_result_if_the_same_data_has_already_been_finalized() {
        let dir = TempDir::new().unwrap();
        let path = dir.path().to_path_buf();

        write_random_file(&path.join("test.txt")).unwrap();

        let cache_path = CachePath::new(path.clone()).unwrap();

        match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { .. } => {}
        };

        cache_path.finalize().unwrap();

        let cache_path = CachePath::new(path).unwrap();

        assert!(matches!(cache_path, CachePath::Cached { .. }));
    }
}
