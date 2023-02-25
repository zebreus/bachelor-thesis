{ pkgs ? import <nixpkgs> { }, symbolator, vcd2wavedrom, bambu, fenix }:
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
    nodePackages.wavedrom-cli
    vcd2wavedrom

    # Utils
    gnumake
    nixpkgs-fmt
    nil
    bambu
    jq

    # For rust
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    fenix.rust-analyzer
    cacert

    # For verilog
    yosys
    nextpnrWithGui
    icestorm
    python3
    verilator

    # Binaries from oss-cad-suite
    aiger
    python310Packages.amaranth
    bitwuzla
    avy
    gtkwave
    dfu-util
    cvc4
    cvc5
    python310Packages.cocotb
    btor2tools
    trellis
    fujprog
    ghdl-llvm
    python310Packages.apycula
    verilog
    usbutils
    mcy
    openfpgaloader
    openocd
    python310Packages.pyserial
    openbabel
    symbiyosys
    surelog
    tinyprog
    python310Packages.xdot
    yices
    python310Packages.z3

    # For C/CPP
    gcc
    clang
    clang-tools
  ];

  # RUST_SRC_PATH = "${unstable-pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  JAVA_HOME = "${adoptopenjdk-hotspot-bin-15}";

  shellHook = ''
    # ...
  '';
}
