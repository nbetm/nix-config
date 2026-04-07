# Reusable Tailscale subnet-router + bastion module.
{ config, lib, ... }:
let
  cfg = config.myConfig.tailscale;
in
{
  options.myConfig.tailscale = {
    enable = lib.mkEnableOption "tailscale subnet router + bastion";

    advertiseRoutes = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        Subnets to advertise to the tailnet. Note: this is documentation
        only — pass the same value to `sudo tailscale up --advertise-routes=...`
        on first bring-up.
      '';
    };

    lanInterfaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Physical LAN interfaces that should also accept SSH.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "server";
      openFirewall = true;
    };

    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];

    # Replace openssh's auto-opened :22 with per-interface rules so SSH
    # only accepts connections on LAN ifaces and the tailnet.
    services.openssh.openFirewall = false;
    networking.firewall.interfaces = lib.genAttrs (cfg.lanInterfaces ++ [ "tailscale0" ]) (_: {
      allowedTCPPorts = [ 22 ];
    });
  };
}
