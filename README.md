# nix-config

![CI](https://img.shields.io/github/actions/workflow/status/nbetm/nix-config/ci.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/nbetm/nix-config)
![Monthly Commit Activity](https://img.shields.io/github/commit-activity/m/nbetm/nix-config)

My NixOS and nix-darwin configs plus dotfiles.

## Hosts

- **aura** - NixOS desktop (x86_64-linux), KDE Plasma
- **atlas** - macOS (aarch64-darwin), nix-darwin
- **andromeda** - NixOS headless VM (aarch64-linux)
- **aphrodite** - NixOS homelab (x86_64-linux), NAS + Jellyfin

## Usage

```bash
make help      # see all commands
make deploy    # apply configuration
make build     # build without switching
make diff      # preview changes before deploy
make ci        # run all checks (nix fmt, flake check, shellcheck, shfmt)
```

## Dotfiles

My dotfiles are in `configs/`.
They use the Stow's `dot-` prefix layout.
This lets me use Stow on non-NixOS machines.
