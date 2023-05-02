{ pkgs ? import <nixpkgs> { }
, symbolator
, vcd2wavedrom
, bambu
, fenix
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
    mkdir -p styles
    mkdir -p images
    make index.html
  '';

  installPhase = ''
    mkdir -p $out
    cp -r *.html *.css images $out
   
    mkdir -p $out/bin
    cat <<EOF > $out/bin/${pname}.sh
    #!/usr/bin/env bash
    python3 -m http.server --directory $out 8000
    EOF
    chmod a+x $out/bin/${pname}.sh
  '';

  meta.mainProgram = "${pname}.sh";
}
