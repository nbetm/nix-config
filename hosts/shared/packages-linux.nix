# Linux packages - CLI tools for all Linux hosts (NixOS)
pkgs: with pkgs; [
  # Development Tools
  gcc
  go

  # Go tooling
  delve
  gofumpt
  golangci-lint
  golangci-lint-langserver
  gopls
  gotools

  # Hashistack
  nomad
  packer
  terraform

  # System Tools
  nvd
]
