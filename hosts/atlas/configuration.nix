# Darwin configuration for atlas (macOS)
{
  config,
  pkgs,
  lib,
  myLib,
  ...
}:

{
  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = myLib.basePackages pkgs ++ myLib.darwinPackages pkgs;

  # Homebrew integration (optional)
  # homebrew = {
  #   enable = true;
  #   brews = [
  #     # Add macOS-specific brews here
  #   ];
  #   casks = [
  #     # Add macOS applications here
  #   ];
  # };

  # System defaults (optional)
  # system.defaults = {
  #   dock.autohide = true;
  #   finder.AppleShowAllExtensions = true;
  #   # Add more macOS system defaults here
  # };

  # Services (optional)
  # services = {
  #   # Add macOS services here
  # };

  # Match the GID used by the Nix installer (new default is 350)
  ids.gids.nixbld = 350;

  # Used for backwards compatibility
  system.stateVersion = 4;
}
