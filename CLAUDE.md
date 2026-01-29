# CLAUDE.md

See @README.md for project overview. Run `make help` for available commands.

## Quick Reference

- **Deploy changes**: `make deploy`
- **Build without switching**: `make build`
- **Format nix files**: `make format`

## Where to Add Packages

- `packages/base.nix` - CLI tools for all systems
- `packages/desktop.nix` - GUI apps (Linux only)
- `packages/darwin.nix` - macOS-specific packages

Use `u.` prefix for unstable packages (e.g., `u.ghostty`).

## Flake Structure

- `flake.nix` - Main config with shared overlay
- `hosts/aura/configuration.nix` - NixOS system config
- `hosts/atlas/configuration.nix` - macOS system config (nix-darwin)

## Don't Modify

- `hosts/*/hardware-configuration.nix` - Auto-generated, will be overwritten
