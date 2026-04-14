# Linux packages - CLI tools for all Linux hosts (NixOS)
pkgs: with pkgs; [
  # Development Tools
  gcc
  go
  zig

  # Go tooling
  delve
  gofumpt
  golangci-lint
  golangci-lint-langserver
  gopls
  gotools

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
