{ pkgs ? import <nixpkgs> { }, symbolator, vcd2wavedrom, bambu, fenix, unstable-nixpkgs }:
with pkgs;
let
  latestNextpnr = unstable-nixpkgs.nextpnr.overrideAttrs (old: {
    pname = "nextpnr";
    version = "0.5"; # usually harmless to omit
    srcs = [
      (fetchFromGitHub {
        owner = "YosysHQ";
        repo = "nextpnr";
        rev = "2f509734dff676b7543a574b64a46be4224a5aa4";
        hash = "sha256-+4jmJVn+Gz94IKCMkXbE3EW66ntCW7v9N9xXtoj2Fp8=";
        name = "nextpnr";
      })
      (fetchFromGitHub {
        owner = "YosysHQ";
        repo = "nextpnr-tests";
        rev = "00c55a9eb9ea2e062b51fe0d64741412b185d95d";
        sha256 = "sha256-83suMftMtnaRFq3T2/I7Uahb11WZlXhwYt6Q/rqi2Yo=";
        name = "nextpnr-tests";
      })
    ];
  });
in
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
    sass

    asciidoctor-web-pdf-with-extensions

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
    lldb_14
    lldb_14.lib
    fenix.rust-analyzer
    cacert

    # For verilog
    unstable-nixpkgs.yosys
    latestNextpnr
    unstable-nixpkgs.icestorm
    unstable-nixpkgs.openfpgaloader
    unstable-nixpkgs.python310Packages.apycula
    unstable-nixpkgs.python3
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
    verilog
    usbutils
    mcy
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
