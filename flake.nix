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
        packages.default = packages.expose;
      }
    );
}
