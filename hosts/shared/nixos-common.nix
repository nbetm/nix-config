# Shared config for NixOS hosts (aura, andromeda).
{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # User
  users.groups.nbetm = {
    gid = 1000;
  };

  users.users.nbetm = {
    isNormalUser = true;
    description = "Nelson Monserrate";
    group = "nbetm";
    extraGroups = [ "users" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICR+Am/2drHgOPkf0pzogA8SRcNhJsdVMDEvfDIrOauO nbetm@localhost"
    ];
    subUidRanges = [
      {
        startUid = 1000;
        count = 1;
      }
      {
        startUid = 100001;
        count = 65534;
      }
    ];
    subGidRanges = [
      {
        startGid = 1000;
        count = 1;
      }
      {
        startGid = 100001;
        count = 65534;
      }
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  # Programs
  programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # Environment
  environment.localBinInPath = true;

  # Services
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
