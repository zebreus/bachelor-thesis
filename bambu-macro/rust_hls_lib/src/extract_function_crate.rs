use std::{
    fs::File,
    io::{self, Write},
    path::{Path, PathBuf},
};

use fs_extra::{
    dir::{copy, CopyOptions},
    file::{self, move_file, remove},
};

pub struct ExtractOptions {
    pub original_crate_path: PathBuf,
    pub target_crate_path: PathBuf,
    pub function_name: String,
    pub crate_name: String,
    /// The file containing the function to be synthesized.
    /// Path is relative to the crate's src directory.
    pub function_file: String,
}

// TODO: This only works in really specific circumstances
fn adjust_sources_to_export_function(options: &ExtractOptions) -> io::Result<()> {
    let ExtractOptions {
        original_crate_path,
        target_crate_path,
        function_name,
        crate_name,
        function_file,
    } = options;

    // let crate_path = target_crate_path.join(crate_name);

    let function_path = target_crate_path.join("src").join(function_file);
    let new_function_path = target_crate_path
        .join("src")
        .join(format!("{function_name}.rs"));

    if function_path.canonicalize().unwrap() != new_function_path.canonicalize().unwrap() {
        move_file(
            function_path,
            new_function_path,
            &file::CopyOptions::new().overwrite(true),
        )
        .expect("Moving the file should never fail");
    }

    let mut lib_file = File::create(target_crate_path.join("src/lib.rs")).unwrap();
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

fn copy_original_crate(options: &ExtractOptions) -> io::Result<()> {
    let ExtractOptions {
        original_crate_path,
        target_crate_path,
        function_name,
        crate_name,
        function_file,
    } = options;

    copy(
        original_crate_path,
        target_crate_path,
        &CopyOptions::new().copy_inside(true),
    )
    .unwrap();
    Ok(())
}

/// Returns the path to the extracted crate if successful.
pub fn extract_function_crate(options: &ExtractOptions) -> io::Result<()> {
    let ExtractOptions {
        original_crate_path,
        target_crate_path,
        function_name,
        crate_name,
        function_file,
    } = options;

    // let dir = tempfile::TempDir::new().unwrap();
    // let target_crate_path = dir.path().join(crate_name).to_path_buf();

    copy_original_crate(options)?;

    adjust_sources_to_export_function(options)?;

    return Ok(());
}

#[cfg(test)]
mod tests {
    use std::process::Command;

    use fs_extra::dir::{copy, CopyOptions};
    use tempfile::TempDir;

    use super::*;

    #[test]
    fn extract_function_that_is_defined_in_lib() {
        todo!()
    }

    #[test]
    fn extract_function_declared_in_module_registered_but_not_exported_in_lib() {
        let dir = TempDir::new().unwrap();

        let target_crate_path = dir.path().join("extract_function_test").to_path_buf();
        let original_crate_path = Path::new("test_suites/extract_function_test")
            .to_path_buf()
            .canonicalize()
            .unwrap();
        let crate_name = "extract_function_test";
        let function_name = "subtract";
        let function_file = "subtract.rs";

        let options = ExtractOptions {
            original_crate_path: original_crate_path,
            target_crate_path: target_crate_path.clone(),
            function_name: function_name.to_string(),
            crate_name: crate_name.to_string(),
            function_file: function_file.to_string(),
        };

        extract_function_crate(&options).unwrap();

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
