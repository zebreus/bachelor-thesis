{
  description = "Bachelor thesis";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    symbolator.url = "github:zebreus/symbolator";
    vcd2wavedrom.url = "github:zebreus/vcd2wavedrom";
  };

  outputs = { self, nixpkgs, fenix, flake-utils, symbolator, vcd2wavedrom }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        name = "thesis";
        packages.expose = import ./expose/default.nix { pkgs = nixpkgs.legacyPackages.${system}; symbolator = symbolator.packages.${system}.symbolator; };
        packages.writing = import ./writing/default.nix { pkgs = nixpkgs.legacyPackages.${system}; symbolator = symbolator.packages.${system}.symbolator; };
        packages.toolchain = import ./toolchain-test/default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.bambu-unwrapped = import ./bambu/default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.bambu-wrapped = import ./bambu/wrapped.nix { pkgs = nixpkgs.legacyPackages.${system}; bambu = packages.bambu-unwrapped; };
        packages.bambu = packages.bambu-wrapped;
        packages.bambu-appimage = import ./bambu/appimage.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.hardware-example = import ./hardware-example/default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.hardware-tang = import ./hardware-tang/default.nix { pkgs = nixpkgs.legacyPackages.${system}; fenix = fenix.packages.${system};  symbolator = symbolator.packages.${system}.symbolator; vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom; bambu = packages.bambu; };
        packages.default = packages.writing;
        devShells.default = import ./shell.nix { pkgs = nixpkgs.legacyPackages.${system}; fenix = fenix.packages.${system}; symbolator = symbolator.packages.${system}.symbolator; vcd2wavedrom = vcd2wavedrom.packages.${system}.vcd2wavedrom; bambu = packages.bambu; };

        apps.bambu = { type = "app"; program = "" + packages.bambu-wrapped + "/bin/bambu"; };
      }
    );
}
