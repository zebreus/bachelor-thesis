{
  description = "Bachelor thesis";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      rec {
        name = "thesis";
        packages.expose = import ./expose/default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.toolchain = import ./toolchain-test/default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.bambu-unwrapped = import ./bambu/default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.bambu-wrapped = import ./bambu/default.nix { pkgs = nixpkgs.legacyPackages.${system}; bambu = bambu-unwrapped; };
        packages.bambu = packages.bambu-wrapped;
        packages.bambu-appimage = import ./bambu/appimage.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.hardware-example = import ./hardware-example/default.nix { pkgs = nixpkgs.legacyPackages.${system}; };

        packages.default = packages.expose;
        devShells.default = import ./shell.nix { pkgs = nixpkgs.legacyPackages.${system}; };

        apps.bambu = { type = "app"; program = "" + packages.bambu-wrapped + "/bin/bambu"; };
      }
    );
}
