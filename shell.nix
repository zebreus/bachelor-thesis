{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    # For docs
    asciidoctor-with-extensions
    nixpkgs-fmt
    graphviz
    gnuplot
    python3

    # For rust
    rust.packages.stable.rustPlatform.rust
    rust.packages.stable.rustPlatform.rustLibSrc
    rustfmt
    cacert

    # For verilog
    yosys
    nextpnrWithGui
    icestorm
    python3
    verilator
  ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

  shellHook = ''
    # ...
  '';
}
