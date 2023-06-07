{ pkgs ? import <nixpkgs> { } }:

with pkgs;
let

  # The asciidoctor.js version
  version = "2.2.6";
  # The ruby asciidoctor core version that is used to generate the javascript
  # Get this from https://github.com/asciidoctor/asciidoctor.js/blob/main/.github/workflows/release.yml#LL27C11-L27C11
  asciidoctorVersion = "2.0.17";

  repo = fetchFromGitHub
    {
      owner = "asciidoctor";
      repo = "asciidoctor.js";
      rev = "v${version}";
      hash = "sha256-32DaAkyz4JNM8s8FUGGW749q6zWFWV1Pgr3lvcMAwDk=";
    };


  asciidoctorTarball = builtins.fetchurl
    {
      url = "https://codeload.github.com/asciidoctor/asciidoctor/tar.gz/v${asciidoctorVersion}";
      sha256 = "0a17i5xz3dn6imb9z8g42dwag6hr7x8zbg7izh6gwfsxinbrp4ya";
    };
in
buildNpmPackage
rec {
  pname = "asciidoctor-js-core";
  inherit version;

  src = "${repo}/packages/core";

  npmBuildScript = "build";

  npmDepsHash = "sha256-WZOxNEcLaXhe++T3Gzl6rh/IFsPgTHS0b2Nv1p49A00=";

  nativeBuildInputs = [ pkgs.buildPackages.makeWrapper pkgs.adoptopenjdk-bin ];

  prePatch = ''
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
    export PUPPETEER_EXECUTABLE_PATH="${lib.getExe pkgs.chromium}"
    mkdir -p build
    ln -s ${asciidoctorTarball} build/asciidoctor.tar.gz
    mkdir -p build/asciidoctor
    tar -xzf build/asciidoctor.tar.gz -C build/asciidoctor --strip-components 1

    # Disable tests that require internet access
    sed -i 's/npm run test:node/true/' package.json
    sed -i 's/npm run test:browser/true/' package.json
    # Disable linting
    sed -i 's/npm run docs:lint/true/' package.json
    sed -i 's/npm run code:lint/true/' package.json
    sed -i 's/npm run lint/true/' package.json
  '';

  # postInstall = ''
  #   # That executable exists just for backwards compatibility and is deprecated.
  #   # rm -rf $out/bin/asciidoctor-pdf

  #   # wrapProgram $out/bin/asciidoctor-web-pdf
  #   #   --set-default PUPPETEER_EXECUTABLE_PATH "${lib.getExe pkgs.chromium}"
  #   #   --set-default PUPPETEER_SKIP_DOWNLOAD 1
  # '';

  meta = with lib;
    {
      description = "A JavaScript port of Asciidoctor";
      homepage = "https://github.com/asciidoctor/asciidoctor.js";
      license = licenses.mit;
      maintainers = with maintainers; [ zebreus ];
      mainProgram = "asciidoctor";
    };
}
