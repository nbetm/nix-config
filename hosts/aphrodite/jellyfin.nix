# Jellyfin with Intel Quick Sync (Gen9 / HD 530) via VAAPI.
# QSV-proper (oneVPL) is Gen12+; no tone-mapping (no 10-bit HEVC decode).
{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    # Own encoding.xml on every start (otherwise settings only apply if
    # the file doesn't exist yet); transcode config is declarative-only
    forceEncodingConfig = true;
    hardwareAcceleration = {
      enable = true;
      type = "vaapi";
      device = "/dev/dri/renderD128";
    };
    transcoding = {
      enableHardwareEncoding = true;
      # Gen9 can't tone-map (no 10-bit HEVC decode)
      enableToneMapping = false;
      hardwareDecodingCodecs = {
        h264 = true;
        hevc = true;
        mpeg2 = true;
        vc1 = true;
        vp8 = true;
        vp9 = true;
        # 10-bit variants stay off - unsupported on Gen9
      };
    };
  };

  # The module adds no group memberships: render for the GPU node,
  # media to read nasstore/media
  users.users.jellyfin.extraGroups = [
    "media"
    "render"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ]; # iHD driver (Broadwell+)
  };
}
