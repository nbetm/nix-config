# Linux packages - CLI tools for all Linux hosts (NixOS)
pkgs: with pkgs; [
  # Development Tools
  gcc
  go
  rustc
  zig

  # Go tooling
  delve
  gofumpt
  golangci-lint
  golangci-lint-langserver
  gopls
  gotools

  # Rust tooling
  cargo
  clippy
  rust-analyzer
  rustfmt

  # Zig tooling
  lldb
  zls

  # Hashistack
  nomad
  packer
  terraform

  # System Tools
  nvd
]
