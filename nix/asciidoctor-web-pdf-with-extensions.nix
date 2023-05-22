{ pkgs ? import <nixpkgs> { } }:

with pkgs;
runCommand "asciidoctor-web-pdf-with-extensions"
{
  buildInputs = [ makeWrapper ];
} ''
  mkdir -p $out/bin

  makeWrapper ${lib.getExe asciidoctor-web-pdf} $out/bin/asciidoctor-web-pdf \
    --suffix NODE_PATH : ${asciidoctor-kroki}/lib/node_modules \
''
