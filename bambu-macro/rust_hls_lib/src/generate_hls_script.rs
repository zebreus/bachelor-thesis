use std::{
    fs::File,
    io::{self, Write},
    path::Path,
};

pub struct GenerateHlsOptions {
    pub function_name: String,
    pub rust_flags: Option<String>,
    pub hls_flags: Option<String>,
}

/// These flags will be used when compiling the extracted crate to LLVM IR.
pub const DEFAULT_RUST_FLAGS: &str = r#"-C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort -C opt-level=s -C llvm-args=--opaque-pointers=false"#;
// LTO seems broken without opaque pointers  -C linker-plugin-lto=on -C embed-bitcode=on -C lto=fat. Provides no benefit anyway as we are linking manually.

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
        rust_flags,
        hls_flags,
    } = options;

    let rust_flags = rust_flags.clone().unwrap_or(DEFAULT_RUST_FLAGS.into());
    let hls_flags = hls_flags.clone().unwrap_or(DEFAULT_HLS_FLAGS.into());

    let create_llvm_command = format!(
        r#"
CRATE_NAME=$(grep -oP '(?<=name = ")[^"]*' Cargo.toml)
CRATE_NAME_UNDERSCORED=$(echo $CRATE_NAME | tr '-' '_')
# WORKSPACE_LOCATION="$(dirname $(cargo locate-project --message-format plain --workspace))"
export RUSTFLAGS='--emit=llvm-bc {rust_flags}'
LLVM_BITCODE_FILES=($(cargo build --release -Z unstable-options --build-plan | jq '.invocations[].outputs[]' -r | grep -Po "^.*\.rlib$" | sed -E 's/lib([^\/]*)\.rlib/\1\.bc /' | tr -d '\n'))
cargo build --release -Z unstable-options
llvm-link --opaque-pointers=false "${{LLVM_BITCODE_FILES[@]}}"  | llvm-extract --opaque-pointers=false --func={function_name} | llvm-dis --opaque-pointers=false -o {function_name}.ll
# cp $WORKSPACE_LOCATION/target/release/deps/${{CRATE_NAME_UNDERSCORED}}-*.ll {function_name}.ll
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
set -xe

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
