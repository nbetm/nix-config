# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.
See @README.md for project overview and @Makefile for available automation commands

## Where to Add Things

- **CLI tools (all systems):** `hosts/shared/packages-base.nix`
- **Linux GUI apps:** `hosts/shared/packages-linux-desktop.nix`
- **macOS-specific packages:** `hosts/shared/packages-darwin.nix`
- **Dotfiles/tool configs:** `configs/<tool>/` following `dot-` prefix stow convention
- **Dotfile symlinks:** `hosts/shared/home-base.nix` (all hosts), `home-desktop.nix` (Linux), `home-darwin.nix` (macOS)
- **Shared NixOS settings:** `hosts/shared/nixos-common.nix`
- **Settings for all hosts:** `hosts/shared/common.nix`

Use `u.` prefix for unstable packages (e.g., `u.ghostty`).

## Home-Manager

Used purely as a symlink engine via `home.file` and `xdg.configFile`.
No `programs.<tool>.enable` modules.
Raw config files only.

## Platform-Specific Configs

ghostty and kitty have `os-darwin.conf` / `os-linux.conf` in the same directory.
The `home-desktop.nix` and `home-darwin.nix` modules select the right one and symlink it as `os.conf`.

## Development Workflow

- Run `make ci` before committing to catch formatting and lint issues
- Run `make build` to verify the config compiles without deploying
- Run `nix flake check --no-build` for quick evaluation-only validation
- New files must be `git add`ed before nix can see them (flake limitation)
- Run `nix fmt` (or `make format`) to auto-format nix files

## Critical Rules

**You MUST follow these rules**:

- **Ask for more information when unsure** - don't make assumptions on the developers behalf
- **Learn from mistakes** - if you make repeated errors or miss important patterns, offer to update CLAUDE.md
- **Sentence-per-line in markdown** - when writing markdown files, put each sentence on its own line
- **Do not inject or rewrite prose** - Developers are ultimately better at explaining the why.
  This includes code comments and docstrings, even when the surrounding code has them.
  You may write prose if the developer explicitly asks, but write all prose in plain language: one idea per sentence, active voice, strong verbs, no filler words, and numbers instead of vague adjectives.
  Use a colon only to introduce a list.
  Never join two thoughts with a semicolon, a dash, or a colon.
  Write two sentences instead.
- **Do not modify** - `hosts/*/hardware-configuration.nix` (auto-generated) and `flake.lock` (update via `make update` or `make upp i=<input>`)
