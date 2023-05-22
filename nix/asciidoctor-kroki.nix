{ pkgs ? import <nixpkgs> { } }:

with pkgs;
buildNpmPackage rec {
  pname = "asciidoctor-kroki";
  version = "0.17.0";

  src = fetchFromGitHub {
    owner = "zebreus";
    repo = pname;
    rev = "01b1fce9c53739fb1cce0b26b2f93e5be478ca99";
    hash = "sha256-osCrIXwHfrCDShXnvzKVbEbDQd59Mk/sQvW6IapEVU8=";
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
