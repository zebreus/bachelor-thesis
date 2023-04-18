use std::{
    fs::File,
    io::{self, Write},
    path::Path,
};

pub struct GenerateHlsOptions {
    pub function_name: String,
    pub crate_name: String,
    pub rust_flags: Option<String>,
    pub hls_flags: Option<String>,
}

/// These flags will be used when compiling the extracted crate to LLVM IR.
pub const DEFAULT_RUST_FLAGS: &str = r#"-C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort -C opt-level=s -C linker-plugin-lto=on -C embed-bitcode=on -C lto=fat -C llvm-args="--opaque-pointers=false""#;

/// These flags will be used when performing HLS from the generated LLVM IR.
pub const DEFAULT_HLS_FLAGS: &str = r#"--compiler=I386_CLANG16 -Os"#;

/// Generate the contents of the HLS script.
///
/// The created script should be executed from a crate directory, that contains the crate described in the options.
///
/// The script will generate a result.v file in the crate directory containing the synthesized Verilog code.
fn generate_hls_script_content(options: &GenerateHlsOptions) -> String {
    let GenerateHlsOptions {
        function_name,
        crate_name,
        rust_flags,
        hls_flags,
    } = options;

    let rust_flags = rust_flags.clone().unwrap_or(DEFAULT_RUST_FLAGS.into());
    let hls_flags = hls_flags.clone().unwrap_or(DEFAULT_HLS_FLAGS.into());

    let create_llvm_command = format!(
        r#"
rm -rf target
cargo rustc --release -- --emit=llvm-ir {rust_flags}
cp target/release/deps/{crate_name}-*.ll {function_name}.ll
"#
    );

    let perform_hls_command = format!(
        r#"
bambu --simulator=VERILATOR {function_name}.ll --top-fname={function_name} --clock-name=clk {hls_flags}
mv {function_name}.v result.v
"#
    );

    return String::from(format!(
        r#"
#!/usr/bin/env bash

# Compile to LLVM IR
{create_llvm_command}

# Perform HLS
{perform_hls_command}
"#
    ));
}

/// Generate the contents of the HLS script.
///
/// The created script should be executed from a crate directory, that contains the crate described in the options.
///
/// The script will generate a result.v file in the crate directory containing the synthesized Verilog code.
pub fn generate_hls_script(crate_path: &Path, options: &GenerateHlsOptions) -> io::Result<()> {
    let path = crate_path.join("hls.sh");
    let mut file = File::create(path)?;
    let content = generate_hls_script_content(options);
    file.write_all(content.as_bytes())?;
    file.sync_all()?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use std::process::Command;

    use fs_extra::dir::{copy, CopyOptions};
    use tempfile::TempDir;

    use super::*;

    #[test]
    fn generate_hls_script_creates_a_file() {
        let dir = TempDir::new().unwrap();

        generate_hls_script(
            &dir.path(),
            &GenerateHlsOptions {
                function_name: "test".into(),
                crate_name: "test".into(),
                rust_flags: None,
                hls_flags: None,
            },
        )
        .unwrap();
        let expected_file_path = dir.path().join("hls.sh");
        assert!(expected_file_path.exists());

        dir.close().unwrap();
    }

    #[test]
    fn synthesizing_test_crate_creates_verilog_file() {
        let dir = TempDir::new().unwrap();
        copy("test_suites/test_crate", dir.path(), &CopyOptions::new()).unwrap();

        let crate_path = dir.path().join("test_crate");
        let crate_name = "test_crate";
        let function_name = "add";

        generate_hls_script(
            &crate_path,
            &GenerateHlsOptions {
                function_name: function_name.into(),
                crate_name: crate_name.into(),
                rust_flags: None,
                hls_flags: None,
            },
        )
        .unwrap();

        let output = Command::new("sh")
            .arg("hls.sh")
            .current_dir(&crate_path)
            .output()
            .expect(
                format!(
                    "Failed to perform HLS in {crate_name} ({})",
                    crate_path.to_str().unwrap()
                )
                .as_str(),
            );

        let exit_code = output.status.code().unwrap();
        if exit_code != 0 {
            println!(
                "Failed HLS. Keeping directory {}",
                crate_path.to_str().unwrap()
            );
            println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
            println!("stderr: {}", String::from_utf8_lossy(&output.stderr));
            let _keep_tempdir = dir.into_path();
        }
        assert_eq!(exit_code, 0);

        assert!(crate_path.join("result.v").exists());
    }
}
