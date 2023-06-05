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
  };

  outputs = { self, nixpkgs, fenix, flake-utils, symbolator, vcd2wavedrom, unstable-nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          overlays = [
            (final: prev: {
              asciidoctor-web-pdf-with-extensions = import ./nix/asciidoctor-web-pdf-with-extensions.nix { pkgs = final; };
              asciidoctor-web-pdf = import ./nix/asciidoctor-web-pdf.nix { pkgs = final; };
              asciidoctor-kroki = import ./nix/asciidoctor-kroki.nix { pkgs = final; };
            })
          ];
          inherit system;
        };
      in
      rec {
        name = "thesis";
        packages.expose = import ./expose/default.nix { pkgs = pkgs; symbolator = symbolator.packages.${system}.symbolator; };
        packages.writing = import ./writing/default.nix { pkgs = pkgs; symbolator = symbolator.packages.${system}.symbolator; };
        packages.toolchain = import ./toolchain-test/default.nix { pkgs = pkgs; };
        packages.bambu-unwrapped = import ./bambu/default.nix { pkgs = unstable-nixpkgs.legacyPackages.${system}; };
        packages.bambu-wrapped = import ./bambu/wrapped.nix { pkgs = unstable-nixpkgs.legacyPackages.${system}; bambu = packages.bambu-unwrapped; };
        packages.bambu = packages.bambu-wrapped;
        packages.bambu-appimage = import ./bambu/appimage.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.hardware-example = import ./hardware-example/default.nix { pkgs = pkgs; };
        packages.hardware-tang = import ./hardware-tang/default.nix { pkgs = pkgs; fenix = fenix.packages.${system}; symbolator = symbolator.packages.${system}.symbolator; vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom; bambu = packages.bambu; };
        packages.rusthdl-intro = import ./rusthdl-intro/default.nix { pkgs = pkgs; fenix = fenix.packages.${system}; symbolator = symbolator.packages.${system}.symbolator; vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom; bambu = packages.bambu; };
        packages.extended-abstract = import ./extended-abstract/default.nix { pkgs = pkgs; fenix = fenix.packages.${system}; symbolator = symbolator.packages.${system}.symbolator; vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom; bambu = packages.bambu; };
        packages.thesis = import ./thesis/default.nix { pkgs = pkgs; fenix = fenix.packages.${system}; symbolator = symbolator.packages.${system}.symbolator; vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom; bambu = packages.bambu; };
        packages.default = packages.writing;
        devShells.default = import ./shell.nix { pkgs = pkgs; fenix = fenix.packages.${system}; symbolator = symbolator.packages.${system}.symbolator; vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom; bambu = packages.bambu; unstable-nixpkgs = unstable-nixpkgs.legacyPackages.${system}; };

        apps.bambu = { type = "app"; program = (pkgs.lib.getExe packages.bambu-wrapped); };
      }
    );
}
