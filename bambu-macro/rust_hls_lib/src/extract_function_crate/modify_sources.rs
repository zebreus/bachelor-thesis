use std::{
    fs::{create_dir_all, File},
    io::Write,
    path::PathBuf,
};

use fs_extra::file::{self, move_file};

use super::ExtractCrateError;

/// Modify the crate at `crate_path` to only export a function from a file
///
/// The current implementation is just a proof of concept and only works if the file does not reference any other files from the same crate.
pub fn modify_sources(
    crate_path: &PathBuf,
    function_name: &str,
    function_file: &PathBuf,
) -> Result<(), ExtractCrateError> {
    let crate_path = crate_path.canonicalize()?;

    let function_file = crate_path.join("src").join(function_file);
    let new_function_path = crate_path.join("src").join(format!("{function_name}.rs"));

    if !function_file.exists() {
        return Err(ExtractCrateError::FunctionFileDoesNotExist {
            function_file: function_file.clone(),
        });
    }

    create_dir_all(crate_path.join("src"))?;

    if function_file != new_function_path {
        move_file(
            function_file,
            new_function_path,
            &file::CopyOptions::new().overwrite(true),
        )?;
    }

    let mut lib_file = File::create(crate_path.join("src/lib.rs"))?;
    let lib_content = format!(
        r#"
mod {function_name};

pub use {function_name}::{function_name};
"#
    );

    lib_file.write_all(lib_content.as_bytes())?;
    lib_file.sync_all()?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use std::process::Command;

    use tempfile::TempDir;

    use crate::extract_function_crate::copy_crate;

    use super::*;

    #[test]
    fn modifying_example_crate_does_not_crash() {
        let dir = TempDir::new().unwrap();

        let target_crate_path = dir.path().join("extract_function_test").to_path_buf();
        let original_crate_path = PathBuf::from("test_suites/extract_function_test")
            .to_path_buf()
            .canonicalize()
            .unwrap();

        copy_crate(&original_crate_path, &target_crate_path).unwrap();

        modify_sources(
            &target_crate_path,
            "subtract",
            &PathBuf::from("subtract.rs"),
        )
        .unwrap();
    }

    #[test]
    fn modifying_example_crate_does_compile_after_modifications() {
        let dir = TempDir::new().unwrap();

        let target_crate_path = dir.path().join("extract_function_test").to_path_buf();
        let original_crate_path = PathBuf::from("test_suites/extract_function_test")
            .to_path_buf()
            .canonicalize()
            .unwrap();

        copy_crate(&original_crate_path, &target_crate_path).unwrap();

        modify_sources(
            &target_crate_path,
            "subtract",
            &PathBuf::from("subtract.rs"),
        )
        .unwrap();

        // Try building the extracted crate
        let output = Command::new("cargo")
            .arg("build")
            .current_dir(&target_crate_path)
            .output()
            .expect("Failed to run cargo build");

        let exit_code = output.status.code().unwrap();
        if exit_code != 0 {
            println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
            println!("stderr: {}", String::from_utf8_lossy(&output.stderr));
            let _keep_tempdir = dir.into_path();
            panic!(
                "Failed to build extracted crate ({})",
                target_crate_path.to_str().unwrap()
            );
        }
    }
}
