# Home-manager config for headless NixOS hosts (andromeda, aphrodite).
# home-base.nix with no desktop additions.
{ ... }:

{
  imports = [ ./home-base.nix ];

  home.username = "nbetm";
  home.homeDirectory = "/home/nbetm";
}
