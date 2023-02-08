{ pkgs ? import <nixpkgs> { }, symbolator }:
with pkgs;
mkShell {
  buildInputs = [
    # For docs
    asciidoctor-with-extensions
    graphviz
    gnuplot
    nodePackages.vega-cli
    nodePackages.vega-lite
    pikchr
    python3
    symbolator
    adoptopenjdk-hotspot-bin-15

    # Utils
    gnumake
    nixpkgs-fmt
    nil

    # For rust
    rust.packages.stable.rustPlatform.rust.rustc
    rust.packages.stable.rustPlatform.rust.cargo
    rust.packages.stable.rustPlatform.rustLibSrc
    rustfmt
    cacert

    # For verilog
    yosys
    nextpnrWithGui
    icestorm
    python3
    verilator

    # For C/CPP
    gcc
    clang
    clang-tools
  ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  JAVA_HOME = "${adoptopenjdk-hotspot-bin-15}";

  shellHook = ''
    # ...
  '';
}
