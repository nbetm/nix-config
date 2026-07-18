# Aphrodite - Headless NixOS homelab
# NAS (Samba) + Jellyfin (x86_64-linux)
{
  config,
  pkgs,
  lib,
  myLib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../shared/nixos-common.nix
    ./zfs.nix
    ./nas.nix
    ./jellyfin.nix
  ];

  networking.hostName = "aphrodite";

  # Static IP via systemd-networkd, matched by MAC so the predictable
  # interface name never matters
  networking.networkmanager.enable = lib.mkForce false;
  networking.useDHCP = false;
  systemd.network.enable = true;
  systemd.network.networks."10-lan" = {
    matchConfig.MACAddress = "70:85:c2:02:64:a7";
    address = [ "192.168.50.198/24" ];
    gateway = [ "192.168.50.1" ];
    dns = [ "192.168.50.1" ];
  };

  # Trust nbetm on the nix daemon so remote pushes from aura
  # (unsigned store paths) are accepted
  nix.settings.trusted-users = [ "nbetm" ];

  # Cleans up after itself
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # User groups (base groups come from nixos-common.nix)
  users.users.nbetm.extraGroups = [
    "media"
    "wheel"
  ];

  # Packages
  environment.systemPackages = myLib.basePackages pkgs ++ myLib.linuxPackages pkgs;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
