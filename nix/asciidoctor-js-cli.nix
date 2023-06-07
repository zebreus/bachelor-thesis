{ pkgs ? import <nixpkgs> { } }:

with pkgs;
let
  asciidoctorJsCore = import ./asciidoctor-js-core.nix {
    pkgs = pkgs;
  };
in
buildNpmPackage
rec {
  pname = "asciidoctor-js-cli";
  version = "3.5.0";


  src = fetchFromGitHub
    {
      owner = "asciidoctor";
      repo = "asciidoctor-cli.js";
      rev = "v${version}";
      hash = "sha256-+Y4PDzL1nTjns0qJSbVKrsJ7jlsXKrzQxEbNMNs7w+4=";
    };


  npmDepsHash = "sha256-VZrHJ2Nc9G/Z+vDxocgXaAYqvd7igtIT0junbg1R9hc=";

  nativeBuildInputs = [ pkgs.buildPackages.makeWrapper pkgs.jq pkgs.adoptopenjdk-bin ];

  prePatch = ''
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
    export PUPPETEER_EXECUTABLE_PATH="${lib.getExe pkgs.chromium}"
  '';

  # postInstall = ''
  #   # That executable exists just for backwards compatibility and is deprecated.
  #   # rm -rf $out/bin/asciidoctor-pdf

  #   # wrapProgram $out/bin/asciidoctor-web-pdf
  #   #   --set-default PUPPETEER_EXECUTABLE_PATH "${lib.getExe pkgs.chromium}"
  #   #   --set-default PUPPETEER_SKIP_DOWNLOAD 1
  # '';

  dontNpmBuild = true;
  meta = with lib;
    {
      description = "A JavaScript port of Asciidoctor";
      homepage = "https://github.com/asciidoctor/asciidoctor.js";
      license = licenses.mit;
      maintainers = with maintainers; [ zebreus ];
      mainProgram = "asciidoctor";
    };
}
