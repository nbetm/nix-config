# nix-config

![CI](https://img.shields.io/github/actions/workflow/status/nbetm/nix-config/ci.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/nbetm/nix-config)
![Monthly Commit Activity](https://img.shields.io/github/commit-activity/m/nbetm/nix-config)

My NixOS and nix-darwin configurations. This isn't meant to be a drop-in solution—it's just how I manage my systems. Feel free to steal ideas, but you'll need to understand Nix basics to make sense of it.

## Hosts

- **aura** - NixOS desktop (x86_64-linux), KDE Plasma
- **atlas** - macOS (aarch64-darwin), nix-darwin (WIP)

## Usage

```bash
make help      # see all commands
make deploy    # apply configuration
make build     # build without switching
make diff      # preview changes before deploy
```

## Structure

```plain
.
├── flake.nix          # main flake with shared overlay
├── hosts/             # per-machine configs
│   ├── aura/          # NixOS
│   └── atlas/         # macOS
└── packages/          # modular package lists
    ├── base.nix       # CLI tools (all systems)
    ├── desktop.nix    # GUI apps (Linux)
    └── darwin.nix     # macOS-specific
```
