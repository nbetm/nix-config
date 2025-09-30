{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-25.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # ghostty terminal - official maintainer flake
    ghostty.url = "github:ghostty-org/ghostty";

    # helix editor - official maintainer flake
    helix.url = "github:helix-editor/helix/master";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ghostty, helix, ... }@inputs: {
    nixosConfigurations.aura = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix

        # Add unstable overlay flake packages
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = prev.system;
                config.allowUnfree = true;
              };
              # ghostty = ghostty.packages.${prev.system}.default;
              # helix = helix.packages.${prev.system}.helix;
            })
          ];
        })
      ];
    };
  };
}
