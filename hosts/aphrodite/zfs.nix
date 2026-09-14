# Import the existing nasstore ZFS mirror. Data only, the OS is ext4.
{ ... }:

{
  boot.supportedFilesystems.zfs = true;

  # Required by ZFS to identify the importing host
  networking.hostId = "a9f0d17e";

  # nixpkgs defaults this to true. An ext4 root has nothing to force-import.
  boot.zfs.forceImportRoot = false;

  # Auto-import the non-root pool at boot
  boot.zfs.extraPools = [ "nasstore" ];

  # Monthly scrub (services.zfs.trim is on by default, and moot on spinning rust)
  services.zfs.autoScrub.enable = true;
}
