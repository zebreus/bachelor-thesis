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
        packages.bambu-unwrapped = import ./default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        packages.bambu = import ./wrapped.nix { pkgs = nixpkgs.legacyPackages.${system}; bambu-unwrapped = packages.bambu-unwrapped; };
        apps.bambu-run = { type = "app"; program = "" + packages.bambu-unwrapped + "/bin/x86_64-linux-bambu"; };
        packages.default = packages.bambu;
      }
    );
}
