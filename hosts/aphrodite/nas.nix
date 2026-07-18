# NAS: single-account Samba (SMB-only) + Avahi discovery for Finder.
{ ... }:

{
  # Shared identity: nas owns the data; the media group grants Jellyfin
  # read access without anything being world-readable
  users.groups.media = { };
  users.groups.nas = { };
  users.users.nas = {
    isSystemUser = true;
    group = "nas";
    extraGroups = [ "media" ];
    # No Unix password or login shell; the only credential is the Samba
    # one, set once post-install with `smbpasswd -a nas`
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    # mDNS handles discovery; no Windows clients, no NetBIOS
    nmbd.enable = false;
    winbindd.enable = false;
    settings = {
      global = {
        "server string" = "aphrodite";
        "server role" = "standalone server";
        security = "user";
        "map to guest" = "never";
        "hosts allow" = "192.168.50. 127.0.0.1 ::1";
        "hosts deny" = "ALL";
        # macOS interop: fruit must stack with streams_xattr, catia first.
        # No fruit:posix_rename - removed in Samba 4.22.
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:aapl" = "yes";
        "fruit:metadata" = "stream";
        "fruit:model" = "MacSamba";
        "fruit:nfs_aces" = "no";
        "fruit:veto_appledouble" = "no";
        "fruit:wipe_intentionally_left_blank_rfork" = "yes";
        "fruit:delete_empty_adfiles" = "yes";
      };
      media = {
        path = "/nasstore/media";
        browseable = "yes";
        writable = "yes";
        "valid users" = "nas";
        "force user" = "nas";
        "force group" = "media";
        "create mask" = "0664";
        "directory mask" = "2775";
      };
      shared = {
        path = "/nasstore/shared";
        browseable = "yes";
        writable = "yes";
        "valid users" = "nas";
        "force user" = "nas";
        "force group" = "nas";
        "create mask" = "0664";
        "directory mask" = "2775";
      };
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
    };
    extraServiceFiles.smb = ''
      <?xml version="1.0" standalone='no'?>
      <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      <service-group>
        <name replace-wildcards="yes">%h</name>
        <service>
          <type>_smb._tcp</type>
          <port>445</port>
        </service>
        <service>
          <type>_device-info._tcp</type>
          <port>0</port>
          <txt-record>model=RackMac</txt-record>
        </service>
      </service-group>
    '';
  };
}
