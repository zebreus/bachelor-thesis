{ pkgs ? import <nixpkgs> { }
}:

with pkgs;
stdenv.mkDerivation {
  pname = "expose";
  version = "0.0.0";

  src = ./.;

  nativeBuildInputs = [
    asciidoctor
    nixpkgs-fmt
  ];

  buildPhase = ''
    asciidoctor expose.adoc -o expose.html
  '';

  installPhase = ''
    mkdir -p $out
    cp expose.html $out
  '';
}
