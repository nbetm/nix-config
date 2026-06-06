# Atlas - macOS (aarch64-darwin), nix-darwin
{
  config,
  pkgs,
  lib,
  myLib,
  ...
}:

{
  imports = [ ../shared/common.nix ];

  # Required for user-scoped options (gnupg agent, etc.)
  system.primaryUser = "nbetm";

  # User home path — required for home-manager to derive homeDirectory
  users.users.nbetm.home = "/Users/nbetm";

  # GPG agent
  programs.gnupg.agent.enable = true;

  # Packages
  environment.systemPackages = myLib.basePackages pkgs ++ myLib.darwinPackages pkgs;

  # Fonts
  fonts.packages = with pkgs; [
    iosevka-n
    iosevka-n-term
    iosevka-n-quasi-proportional
  ];

  # Match the GID used by the Nix installer (new default is 350)
  ids.gids.nixbld = 350;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
