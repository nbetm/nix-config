# Darwin configuration for atlas (macOS)
{
  config,
  pkgs,
  lib,
  myLib,
  ...
}:

{
  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # Required for user-scoped options (gnupg agent, etc.)
  system.primaryUser = "nbetm";

  # System packages
  environment.systemPackages = myLib.basePackages pkgs ++ myLib.darwinPackages pkgs;

  # Shell programs
  programs.zsh.enable = true;
  programs.bash = {
    enable = true;
    completion.enable = true;
  };
  programs.direnv.enable = true;
  programs.gnupg.agent.enable = true;

  # Environment
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    UV_PYTHON_DOWNLOADS = "never";
  };

  # Match the GID used by the Nix installer (new default is 350)
  ids.gids.nixbld = 350;

  # Used for backwards compatibility
  system.stateVersion = 4;
}
