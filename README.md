# nix-config

![CI](https://img.shields.io/github/actions/workflow/status/nbetm/nix-config/ci.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/nbetm/nix-config)
![Monthly Commit Activity](https://img.shields.io/github/commit-activity/m/nbetm/nix-config)

My NixOS and nix-darwin configurations. This isn't meant to be a drop-in solution, it's just how I manage my systems. Feel free to steal ideas, but you'll need to understand Nix basics to make sense of it.

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

## Structure

```
.
├── flake.nix              # main flake with shared overlay
├── configs/               # dotfiles and tool configs (stow-compatible)
│   ├── shell/             # zsh, bash, direnv
│   ├── ghostty/           # with os-darwin.conf / os-linux.conf
│   ├── kitty/             # with os-darwin.conf / os-linux.conf
│   └── ...                # bat, btop, delta, git, helix, tmux, etc.
├── hosts/
│   ├── shared/            # shared modules, packages, home-manager
│   │   ├── common.nix     # all hosts (nix settings, shells, env vars)
│   │   ├── nixos-common.nix  # NixOS hosts (boot, locale, user, ssh)
│   │   ├── virtualization.nix # docker, incus, libvirtd, networking
│   │   ├── home-base.nix  # dotfile symlinks for all hosts
│   │   ├── home-desktop.nix   # adds terminal emulators + plasma
│   │   ├── home-darwin.nix    # adds terminal emulators (macOS)
│   │   └── packages-*.nix # base, darwin, linux-desktop
│   ├── aura/              # NixOS desktop
│   ├── atlas/             # macOS
│   └── andromeda/         # NixOS headless VM
└── Makefile
```

## Dotfiles

Tool configs live in `configs/` using stow-compatible `dot-` prefix layout. On nix-managed systems, home-manager symlinks them into `$HOME`. On non-nix machines (Proxmox), stow works too: `stow --dotfiles -d configs -t ~ shell`.

Platform-specific configs (ghostty, kitty) keep `os-darwin.conf` and `os-linux.conf` side by side. Nix selects the right one per host.
