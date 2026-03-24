# Shared config for ALL hosts (NixOS + nix-darwin).
{ pkgs, myLib, ... }:

{
  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # Shells
  programs.zsh.enable = true;
  programs.bash = {
    enable = true;
    completion.enable = true;
  };
  programs.direnv.enable = true;

  # Environment
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    UV_PYTHON_DOWNLOADS = "never";
  };
}
