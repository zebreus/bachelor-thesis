{ pkgs ? import <nixpkgs> { }
}:

with pkgs;
stdenv.mkDerivation {
  pname = "expose";
  version = "0.0.0";

  src = ./.;

  nativeBuildInputs = [
    asciidoctor-js
    nixpkgs-fmt
    graphviz
    gnuplot
    nodePackages.vega-cli
    nodePackages.vega-lite
    pikchr
    symbolator
  ];

  buildInputs = [
    python3
  ];

  buildPhase = ''
    asciidoctor expose.adoc -o expose.html    
  '';

  installPhase = ''
    mkdir -p $out
    cp expose.html $out

    mkdir -p $out/bin
    cat <<EOF > $out/bin/host-expose.sh
    #!/bin/bash
    python3 -m http.server --directory $out 8000
    EOF
    chmod a+x $out/bin/host-expose.sh
  '';

  meta.mainProgram = "host-expose.sh";
}
