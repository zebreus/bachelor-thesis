{ pkgs ? import <nixpkgs> { }
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "hardware-tang";
  version = "0.0.0";

  src = ./..;

  buildInputs = [
    verilator
  ];

  nativeBuildInputs = [
    # For docs
    asciidoctor-js
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
    clang
  ];

  buildPhase = ''
    cd hardware-tang
    make state_test.v state_test.native.log state_test.wavejson state_test_b.wavejson state_test_c.wavejson md5.v index.html
  '';

  installPhase = ''
    mkdir -p $out
    cp -r index.html images $out
   
    mkdir -p $out/bin
    cat <<EOF > $out/bin/${pname}.sh
    #!/usr/bin/env bash
    python3 -m http.server --directory $out 8000
    EOF
    chmod a+x $out/bin/${pname}.sh
  '';

  meta.mainProgram = "${pname}.sh";
}
