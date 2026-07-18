# Import the existing nasstore ZFS mirror (data only - the OS is ext4).
{ ... }:

{
  boot.supportedFilesystems.zfs = true;

  # Required by ZFS to identify the importing host
  networking.hostId = "a9f0d17e";

  # No ZFS root, so no force-import in the initrd (26.11's default)
  boot.zfs.forceImportRoot = false;

  # Auto-import the non-root pool at boot
  boot.zfs.extraPools = [ "nasstore" ];

  # Monthly scrub (services.zfs.trim is on by default; moot on spinning rust)
  services.zfs.autoScrub.enable = true;
}
