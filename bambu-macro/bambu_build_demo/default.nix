{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  thesisFlake = builtins.getFlake "github:zebreus/bachelor-thesis";
  bambu = thesisFlake.outputs.packages.x86_64-linux.bambu;
in
stdenv.mkDerivation {
  name = "test";
  buildInputs = [
    bambu
  ];

  buildCommand = ''
    mkdir -p $out
    echo hi > $out/file.txt
  '';
}
