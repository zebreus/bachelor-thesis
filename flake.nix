{
  description = "Bachelor thesis";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-22.11";
    unstable-nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    symbolator.url = "github:zebreus/symbolator";
    vcd2wavedrom.url = "github:zebreus/vcd2wavedrom";
    nixpkgs-with-asciidoctorjs.url = "github:zebreus/nixpkgs?ref=f1a3be7a1160cc4810c0274ab76f0fac813eb4d6";
  };

  outputs = { self, nixpkgs, fenix, flake-utils, symbolator, vcd2wavedrom, unstable-nixpkgs, nixpkgs-with-asciidoctorjs }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        pkgs-with-asciidoctorjs = import nixpkgs-with-asciidoctorjs { inherit system; };
        pkgs = import unstable-nixpkgs {
          overlays = [
            (final: prev: {
              inherit (pkgs-with-asciidoctorjs) asciidoctor-js asciidoctor-web-pdf;
              asciidoctor-kroki = import ./nix/asciidoctor-kroki.nix { pkgs = final; };
              symbolator = symbolator.packages.${system}.symbolator;
              fenix = fenix.packages.${system};
              vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom;
              bambu-unwrapped = packages.bambu-unwrapped;
              bambu-wrapped = packages.bambu-wrapped;
              bambu = packages.bambu;
            })
          ];
          inherit system;
        };

        name = "thesis";
        packages.ad = import ./nix/asciidoctor-web-pdf.nix { pkgs = pkgs; };
        packages.expose = import ./expose/default.nix { pkgs = pkgs; };
        packages.writing = import ./writing/default.nix { pkgs = pkgs; };
        packages.toolchain = import ./toolchain-test/default.nix { pkgs = pkgs; };
        packages.bambu-unwrapped = import ./bambu/default.nix { pkgs = pkgs; };
        packages.bambu-wrapped = import ./bambu/wrapped.nix { pkgs = pkgs; };
        packages.bambu = packages.bambu-wrapped;
        packages.bambu-appimage = import ./bambu/appimage.nix { pkgs = pkgs; };
        packages.hardware-example = import ./hardware-example/default.nix { pkgs = pkgs; };
        packages.hardware-tang = import ./hardware-tang/default.nix { pkgs = pkgs; };
        packages.rusthdl-intro = import ./rusthdl-intro/default.nix { pkgs = pkgs; };
        packages.extended-abstract = import ./extended-abstract/default.nix { pkgs = pkgs; };
        packages.thesis = import ./thesis/default.nix { pkgs = pkgs; };
        packages.thesis-pdf = import ./thesis/pdf.nix { pkgs = pkgs; };
        packages.default = packages.writing;
        devShells.default = import ./shell.nix { pkgs = pkgs; };

        apps.bambu = { type = "app"; program = (pkgs.lib.getExe packages.bambu-wrapped); };
      }
    );
}
