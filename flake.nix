{
  description = "Multi-system NixOS configuration and development tools";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Flake utilities for multi-system support
    flake-utils.url = "github:numtide/flake-utils";

    # nix-darwin for macOS system management
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # xremap - key remapper for macOS-style shortcuts
    xremap-flake.url = "github:xremap/nix-flake";

    # llm-agents - fresher AI coding agents (claude-code, codex, gemini-cli)
    # No `inputs.nixpkgs.follows`: overlays.default uses its own pinned nixpkgs
    # so we get binary-cache hits from upstream.
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      nix-darwin,
      ...
    }@inputs:
    let
      # Modular package management system
      myLib = {
        # Import package lists from separate files
        basePackages = import ./hosts/shared/packages-base.nix;
        linuxPackages = import ./hosts/shared/packages-linux.nix;
        linuxDesktopPackages = import ./hosts/shared/packages-linux-desktop.nix;
        darwinPackages = import ./hosts/shared/packages-darwin.nix;
      };

      # Shared overlay - cross-platform packages
      sharedOverlay =
        final: prev:
        {
          unstable = import nixpkgs-unstable {
            system = prev.stdenv.hostPlatform.system;
            config.allowUnfree = true;
          };
          # Short alias for unstable packages
          u = final.unstable;
          # Workaround: direnv 2.37.1 in stable fails to build on darwin (cgo linking)
          direnv = final.unstable.direnv;
        }
        // (import ./pkgs/iosevka-n {
          inherit (prev) lib stdenvNoCC fetchurl;
        });
    in
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ]
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = prev.stdenv.hostPlatform.system;
                  config.allowUnfree = true;
                };
                # Short alias for unstable packages
                u = final.unstable;
              })
              inputs.llm-agents.overlays.default
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

          # Formatter for `nix fmt`
          formatter = pkgs.nixfmt-tree;
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
          inputs.xremap-flake.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              sharedOverlay
              inputs.llm-agents.overlays.default
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nbetm = import ./hosts/shared/home-desktop.nix;
          }
        ];
      };

      # Andromeda - Headless NixOS VM (aarch64-linux)
      nixosConfigurations.andromeda = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
          myLib = myLib;
        };
        modules = [
          ./hosts/andromeda/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              sharedOverlay
              inputs.llm-agents.overlays.default
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nbetm = {
              imports = [ ./hosts/shared/home-base.nix ];
              home.username = "nbetm";
              home.homeDirectory = "/home/nbetm";
            };
          }
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
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [
              sharedOverlay
              inputs.llm-agents.overlays.default
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nbetm = import ./hosts/shared/home-darwin.nix;
          }
        ];
      };
    };
}
