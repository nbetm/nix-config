{ inputs, ... }:
{
  imports = [ inputs.rex.nixosModules.default ];

  services.rex.loginServer = {
    enable = true;
    accounts.nbetm.principals = [ "tailscale:*" ];
    tailscaleServe.enable = true;
  };
}
