# Home-manager config for Linux desktop hosts (aura).
# Imports home-base.nix and adds terminal emulators + desktop configs.
{ ... }:

{
  imports = [ ./home-base.nix ];

  home.username = "nbetm";
  home.homeDirectory = "/home/nbetm";

  # Terminal emulators
  xdg.configFile = {
    # Ghostty
    "ghostty/config".source = ../../configs/ghostty/dot-config/ghostty/config;
    "ghostty/themes/nord-deep".source = ../../configs/ghostty/dot-config/ghostty/themes/nord-deep;
    "ghostty/os.conf".source = ../../configs/ghostty/dot-config/ghostty/os-linux.conf;

    # Kitty
    "kitty/kitty.conf".source = ../../configs/kitty/dot-config/kitty/kitty.conf;
    "kitty/themes/nord-deep.conf".source = ../../configs/kitty/dot-config/kitty/themes/nord-deep.conf;
    "kitty/os.conf".source = ../../configs/kitty/dot-config/kitty/os-linux.conf;
    "kitty/.helix".source = ../../configs/kitty/dot-config/kitty/.helix;
  };

  # Plasma theme
  home.file.".local/share/color-schemes/NordDeep.colors".source =
    ../../configs/plasma/dot-local/share/color-schemes/NordDeep.colors;
}
