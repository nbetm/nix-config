# Home-manager config for macOS hosts (atlas).
# Imports home-base.nix and adds terminal emulators.
{ ... }:

{
  imports = [ ./home-base.nix ];

  home.username = "nbetm";
  home.homeDirectory = "/Users/nbetm";

  # Terminal emulators
  xdg.configFile = {
    # Ghostty
    "ghostty/config".source = ../../configs/ghostty/dot-config/ghostty/config;
    "ghostty/themes/nord-deep".source = ../../configs/ghostty/dot-config/ghostty/themes/nord-deep;
    "ghostty/os.conf".source = ../../configs/ghostty/dot-config/ghostty/os-darwin.conf;

    # Kitty
    "kitty/kitty.conf".source = ../../configs/kitty/dot-config/kitty/kitty.conf;
    "kitty/themes/nord-deep.conf".source = ../../configs/kitty/dot-config/kitty/themes/nord-deep.conf;
    "kitty/os.conf".source = ../../configs/kitty/dot-config/kitty/os-darwin.conf;
    "kitty/.helix".source = ../../configs/kitty/dot-config/kitty/.helix;
  };
}
