use clap::Parser;
use rust_hls_lib::Build;

/// Search for a pattern in a file and display the lines that contain it.
#[derive(Parser)]
struct Cli {
    /// The pattern to look for
    directory: std::path::PathBuf,
}

fn main() {
    let args = Cli::parse();

    Build::new().crate_root(args.directory).synthesize();
}
