# Andromeda - Headless NixOS VM (aarch64-linux)
# On-the-go dev alternative to aura, accessed via SSH.
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
    ../shared/virtualization.nix
  ];

  networking.hostName = "andromeda";

  # Static DNS — Fusion's NAT DNS proxy returns malformed responses on macOS Sequoia
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
  networking.networkmanager.dns = "none";

  # User groups (base groups come from nixos-common.nix, these are andromeda-specific)
  users.users.nbetm.extraGroups = [
    "docker"
    "incus-admin"
    "kvm"
    "libvirtd"
    "qemu-libvirtd"
    "wheel"
  ];

  # Packages
  environment.systemPackages = myLib.basePackages pkgs ++ myLib.linuxPackages pkgs;

  # VMware guest support (andromeda runs as a Fusion VM)
  virtualisation.vmware.guest.enable = true;

  system.stateVersion = "25.11";
}
