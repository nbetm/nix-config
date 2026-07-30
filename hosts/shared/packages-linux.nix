# Linux packages - CLI tools for all Linux hosts (NixOS)
pkgs: with pkgs; [
  # C
  clang-tools
  cmake
  gcc
  gdb
  lldb
  pkg-config

  # Elixir
  elixir
  elixir-ls

  # Go
  delve
  go
  gofumpt
  golangci-lint
  golangci-lint-langserver
  gopls
  gotools

  # Rust
  cargo
  clippy
  rust-analyzer
  rustc
  rustfmt

  # Zig
  zig
  zls

  # Hashistack
  u.nomad
  u.packer
  u.tenv
  u.terraform
  u.terraform-ls
  u.tflint

  # System Tools
  nvd
  samba
]
