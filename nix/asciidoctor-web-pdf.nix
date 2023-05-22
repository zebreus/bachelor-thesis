{ pkgs ? import <nixpkgs> { } }:

with pkgs;
buildNpmPackage rec {
  pname = "asciidoctor-web-pdf";
  version = "1.0.0-alpha.16";

  src = fetchFromGitHub {
    owner = "ggrossetie";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-IIxYQ2ZcLZFr1cR+3Xeghoq5TuUuDSQb/wHGzhazE6o=";
  };

  PUPPETEER_SKIP_DOWNLOAD = "1";

  npmDepsHash = "sha256-N/r3pvE98kND5cZZFZxY7UzHTt7tQMVNN0kqWmCsK4s=";

  # Skip npm build because we do not want a bundled executable
  dontNpmBuild = true;
  # Skip the Makefile build phase, because we do not want to build the docker container
  buildPhase = "true";

  postInstall = ''
    # That executable exists just for backward compatibility and is deprecated.
    rm -rf $out/bin/asciidoctor-pdf

    wrapProgram $out/bin/asciidoctor-web-pdf \
      --set-default PUPPETEER_EXECUTABLE_PATH "${lib.getExe chromium}" \
      --set-default PUPPETEER_SKIP_DOWNLOAD 1
  '';

  meta = with lib;
    {
      description = "Convert AsciiDoc documents to PDF using web technologies";
      homepage = "https://github.com/ggrossetie/asciidoctor-web-pdf";
      license = licenses.mit;
      maintainers = with maintainers; [ zebreus ];
      mainProgram = "asciidoctor-web-pdf";
    };
}
