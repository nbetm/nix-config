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

  # Direnv
  programs.direnv = {
    enable = true;
    settings.whitelist.prefix = [
      "~/projects/personal/aoc/"
      "~/projects/personal/iac/"
      "~/projects/personal/iosevka-n/"
      "~/projects/personal/nix-config/"
      "~/projects/px/cli"
      "~/projects/px/dashx"
      "~/projects/px/examples"
      "~/projects/px/iac"
      "~/projects/px/testbench"
      "~/projects/px/webx"
    ];
  };

  # Environment
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    UV_PYTHON_DOWNLOADS = "never";
  };
}
