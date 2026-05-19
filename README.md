# nix-config

![CI](https://img.shields.io/github/actions/workflow/status/nbetm/nix-config/ci.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/nbetm/nix-config)
![Monthly Commit Activity](https://img.shields.io/github/commit-activity/m/nbetm/nix-config)

My NixOS and nix-darwin configs.
Just how I manage my systems.
Poke around if you find anything useful, but you'll need to know Nix to make sense of it.

## Hosts

- **aura** - NixOS desktop (x86_64-linux), KDE Plasma
- **atlas** - macOS (aarch64-darwin), nix-darwin
- **andromeda** - NixOS headless VM (aarch64-linux)

## Usage

```bash
make help      # see all commands
make deploy    # apply configuration
make build     # build without switching
make diff      # preview changes before deploy
make ci        # run all checks (nix fmt, flake check, shellcheck, shfmt)
```

## Dotfiles

Everything in `configs/` uses stow's `dot-` prefix layout: one set of files for both nix and non-nix machines.
Nix hosts: home-manager symlinks them into `$HOME`.
Everywhere else: `cd configs && stow shell`.
