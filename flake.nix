{
  description = "Bachelor thesis";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mylocalpackages = {
      url = "github:zebreus/nixpkgs/bambu";
    };
    nixpkgs.url = "nixpkgs/nixos-22.11";
    old-nixpkgs.url = "nixpkgs/nixos-21.05";
    unstable-nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    symbolator.url = "github:zebreus/symbolator";
    vcd2wavedrom.url = "github:zebreus/vcd2wavedrom";
    nixpkgs-with-asciidoctorjs.url = "github:zebreus/nixpkgs?ref=f1a3be7a1160cc4810c0274ab76f0fac813eb4d6";
  };

  outputs = { self, nixpkgs, fenix, flake-utils, symbolator, vcd2wavedrom, unstable-nixpkgs, old-nixpkgs, nixpkgs-with-asciidoctorjs, mylocalpackages }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        pkgs-with-asciidoctorjs = import nixpkgs-with-asciidoctorjs { inherit system; };
        asciidoctor-kroki = import ./nix/asciidoctor-kroki.nix { pkgs = pkgs; };
        old-pkgs = import old-nixpkgs { inherit system; };
        mylocal-pkgs = import mylocalpackages { inherit system; };
        pkgs = import unstable-nixpkgs {
          overlays = [
            (final: prev: {
              asciidoctor-js = (pkgs-with-asciidoctorjs.asciidoctor-js.asciidoctor-js).override { extensions = [ asciidoctor-kroki ]; };
              asciidoctor-web-pdf = pkgs-with-asciidoctorjs.asciidoctor-web-pdf.override { extensions = [ asciidoctor-kroki ]; };
              asciidoctor-revealjs = pkgs-with-asciidoctorjs.asciidoctor-revealjs.override { extensions = [ asciidoctor-kroki ]; };
              symbolator = symbolator.packages.${system}.symbolator;
              fenix = fenix.packages.${system};
              vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom;
              # bambu-unwrapped = packages.bambu-unwrapped;
              # bambu-wrapped = packages.bambu-wrapped;
              bambu = mylocal-pkgs.bambu;
            })
          ];
          inherit system;
        };

        name = "thesis";
        packages.ad = import ./nix/asciidoctor-web-pdf.nix { pkgs = pkgs; };
        packages.expose = import ./expose/default.nix { pkgs = pkgs; };
        packages.writing = import ./writing/default.nix { pkgs = pkgs; };
        packages.toolchain = import ./toolchain-test/default.nix { pkgs = pkgs; };
        # packages.bambu-unwrapped = import ./bambu/default.nix { pkgs = pkgs; };
        # packages.bambu-wrapped = import ./bambu/wrapped.nix { pkgs = pkgs; };
        packages.bambu = mylocal-pkgs.bambu;
        packages.bambu-appimage = import ./bambu/appimage.nix { pkgs = pkgs; };
        packages.hardware-example = import ./hardware-example/default.nix { pkgs = pkgs; };
        packages.hardware-tang = import ./hardware-tang/default.nix { pkgs = pkgs; };
        packages.rusthdl-intro = import ./rusthdl-intro/default.nix { pkgs = pkgs; };
        packages.extended-abstract = import ./extended-abstract/default.nix { pkgs = pkgs; };
        packages.thesis = import ./thesis/default.nix { pkgs = pkgs; };
        packages.thesis-pdf = import ./thesis/pdf.nix { pkgs = pkgs; };
        packages.default = packages.writing;
        devShells.default = import ./shell.nix { pkgs = pkgs; old-pkgs = old-pkgs; };
        packages.container = pkgs.dockerTools.buildLayeredImage
          {
            name = "bambu";
            contents = [ packages.bambu-wrapped ];
            config = {
              Cmd = [
                "${pkgs.lib.getExe packages.bambu-wrapped}"
              ];
            };
          };

        apps.bambu = { type = "app"; program = (pkgs.lib.getExe packages.bambu-wrapped); };
      }
    );
}
