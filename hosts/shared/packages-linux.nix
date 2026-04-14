# Linux packages - CLI tools for all Linux hosts (NixOS)
pkgs: with pkgs; [
  # Development Tools
  gcc
  go
  luajit
  rustc
  zig

  # C tooling
  clang-tools
  cmake
  gdb
  pkg-config

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

  # Lua tooling
  lua-language-server
  selene
  stylua

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
