{ pkgs ? import <nixpkgs> { }, symbolator
}:

with pkgs;
stdenv.mkDerivation {
  pname = "writing";
  version = "0.0.0";

  src = ./.;

  nativeBuildInputs = [
    asciidoctor-with-extensions
    nixpkgs-fmt
    graphviz
    gnuplot
    nodePackages.vega-cli
    nodePackages.vega-lite
    pikchr
    symbolator
    python3
  ];

  buildPhase = ''
    asciidoctor -r asciidoctor-diagram first-toolchain.adoc -o index.html
  '';

  installPhase = ''
    mkdir -p $out
    cp index.html $out

    mkdir -p $out/results
    cp results/* $out/results

    mkdir -p $out/images
    cp images/* $out/images

    cp compiler_info.csv $out

    mkdir -p $out/bin
    cat <<EOF > $out/bin/host-writing.sh
    #!/usr/bin/env bash
    python3 -m http.server --directory $out 8000
    EOF
    chmod a+x $out/bin/host-writing.sh
  '';

  meta.mainProgram = "host-writing.sh";
}
