# Linux packages - CLI tools for all Linux hosts (NixOS)
pkgs: with pkgs; [
  # Development Tools
  gcc

  # Docker Engine (macOS uses colima instead)
  docker_29

  # System Tools
  nvd
]
