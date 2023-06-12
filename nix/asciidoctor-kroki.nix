{ pkgs ? import <nixpkgs> { } }:

with pkgs;
buildNpmPackage rec {
  pname = "asciidoctor-kroki";
  version = "0.17.0";

  src = fetchFromGitHub {
    owner = "zebreus";
    repo = pname;
    rev = "ebe6041364294d77b60081b5584743b0b13fc2f9";
    hash = "sha256-it11dDBGOnPlCuqb3Fht2+3vtKxE912iWSQTsQfR2sA=";
  };

  PUPPETEER_SKIP_DOWNLOAD = "1";
  npmDepsHash = "sha256-t4DkPQzMqIzbckHlVAW5lp9lEA6HbfpRHs2ZqJXuhv0=";

  dontNpmBuild = true;

  meta = with lib;
    {
      description = "An extension for Asciidoctor.js to convert diagrams to images using Kroki";
      homepage = "https://github.com/ggrossetie/asciidoctor-kroki";
      license = licenses.mit;
      maintainers = with maintainers; [ zebreus ];
    };
}
