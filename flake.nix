{
  description = "Multi-system NixOS configuration and development tools";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Flake utilities for multi-system support
    flake-utils.url = "github:numtide/flake-utils";

    # nix-darwin for macOS system management
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # xremap for keyboard remapping
    xremap-flake.url = "github:xremap/nix-flake";

    # home-manager
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-25.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # ghostty terminal - official maintainer flake
    # ghostty.url = "github:ghostty-org/ghostty";

    # helix editor - official maintainer flake
    # helix.url = "github:helix-editor/helix/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      nix-darwin,
      xremap-flake,
      ...
    }@inputs:
    let
      # Modular package management system
      myLib = {
        # Import package lists from separate files
        basePackages = import ./packages/base.nix;
        desktopPackages = import ./packages/desktop.nix;
        darwinPackages = import ./packages/darwin.nix;
      };
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = prev.system;
                config.allowUnfree = true;
              };
              # Short alias for unstable packages
              u = final.unstable;
            })
          ];
        };
      in
      {
        # Dev tools package for non-NixOS systems
        packages.dev-tools = pkgs.buildEnv {
          name = "dev-tools";
          paths = myLib.basePackages pkgs;
          pathsToLink = [
            "/bin"
            "/share/man"
            "/share/info"
          ];
          ignoreCollisions = true;
        };
      }
    )
    // {
      # NixOS system configuration
      nixosConfigurations.aura = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          myLib = myLib;
        };
        modules = [
          ./hosts/aura/configuration.nix
          xremap-flake.nixosModules.default

          # Add unstable overlay
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    system = prev.system;
                    config.allowUnfree = true;
                  };
                  # Short alias for unstable packages
                  u = final.unstable;
                  # Custom packages
                  klassy = prev.callPackage ./pkgs/klassy { };
                })
              ];
            }
          )
        ];
      };

      # Darwin system configuration
      darwinConfigurations.atlas = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin"; # Change to x86_64-darwin for Intel Macs
        specialArgs = {
          inherit inputs;
          myLib = myLib;
        };
        modules = [
          ./hosts/atlas/configuration.nix

          # Add unstable overlay
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    system = prev.system;
                    config.allowUnfree = true;
                  };
                  # Short alias for unstable packages
                  u = final.unstable;
                  # Custom packages
                  klassy = prev.callPackage ./pkgs/klassy { };
                })
              ];
            }
          )
        ];
      };
    };
}
