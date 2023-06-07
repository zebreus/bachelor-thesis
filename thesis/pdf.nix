{ pkgs ? import <nixpkgs> { }
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "thesis";
  version = "0.0.0";

  src = ./.;

  buildInputs = [
    verilator
  ];

  nativeBuildInputs = [
    # For docs
    asciidoctor-web-pdf
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
    sass

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
    make thesis.pdf
  '';

  installPhase = ''
    mkdir -p $out
    cp thesis.pdf $out
   
    mkdir -p $out/bin
    cat <<EOF > $out/bin/${pname}.sh
    #!/usr/bin/env bash
    
    xdg-open $out/thesis.pdf
    EOF
    chmod a+x $out/bin/${pname}.sh
  '';

  meta.mainProgram = "${pname}.sh";
}
