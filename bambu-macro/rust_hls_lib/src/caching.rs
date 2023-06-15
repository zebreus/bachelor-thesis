mod calculate_hash;
mod generate_cached_path;
use fs_extra::dir::{copy, CopyOptions};
use rand::{distributions::Alphanumeric, thread_rng, Rng};
use std::{
    fs::{self, OpenOptions},
    io::{self, Write},
    path::PathBuf,
};

use thiserror::Error;

pub use generate_cached_path::get_cache_path;

use crate::rust_hls::CrateFile;

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

    pub fn from_files(based_on: &Vec<CrateFile>) -> Result<CachePath, CachingError> {
        let hash = calculate_hash::calculate_hash(based_on)?;
        let ready_cache_path = generate_cached_path::generate_cached_path(&hash)?;
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
            for crate_file in based_on {
                let target_file = working_cache_path.join(&crate_file.path);
                let prefix = target_file.parent().ok_or(std::io::Error::new(
                    std::io::ErrorKind::Other,
                    format!(
                        "Failed to get parent directory of {}",
                        target_file.display()
                    ),
                ))?;

                std::fs::create_dir_all(prefix)?;
                let mut new_file = OpenOptions::new()
                    .create(true)
                    .write(true)
                    .open(&target_file)?;
                new_file.write_all(crate_file.content.as_bytes())?;
                new_file.sync_all()?;
            }

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

    use super::*;

    fn get_random_file(path: &PathBuf) -> CrateFile {
        let content: String = thread_rng()
            .sample_iter(&Alphanumeric)
            .take(100)
            .map(char::from)
            .collect();

        return CrateFile {
            path: path.clone(),
            content,
        };
    }

    #[test]
    fn unknown_input_results_in_unchached_variant() {
        let files = vec![get_random_file(&PathBuf::from("test.txt"))];

        let cache_path = CachePath::from_files(&files).unwrap();

        match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { .. } => {}
        }
    }

    #[test]
    fn same_input_twice_without_finalizing_results_in_two_unchached_variants_with_same_final_path()
    {
        let random_file = get_random_file(&PathBuf::from("test.txt"));

        let files = vec![random_file.clone()];

        let cache_path = CachePath::from_files(&files).unwrap();

        let final_path1 = match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { final_path, .. } => final_path,
        };

        let cache_path = CachePath::from_files(&files).unwrap();

        let final_path2 = match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { final_path, .. } => final_path,
        };

        assert_eq!(final_path1, final_path2);
    }

    #[test]
    fn finalize_returns_a_cached_path() {
        let files = vec![get_random_file(&PathBuf::from("test.txt"))];

        let cache_path = CachePath::from_files(&files).unwrap();

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
        let files = vec![get_random_file(&PathBuf::from("test.txt"))];

        let cache_path = CachePath::from_files(&files).unwrap();

        match cache_path {
            CachePath::Cached { .. } => panic!("Expected uncached variant"),
            CachePath::Uncached { .. } => {}
        };

        cache_path.finalize().unwrap();

        let cache_path = CachePath::from_files(&files).unwrap();

        assert!(matches!(cache_path, CachePath::Cached { .. }));
    }
}
