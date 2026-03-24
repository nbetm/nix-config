# Aura - NixOS desktop (x86_64-linux), KDE Plasma
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

  # KVM kernel modules
  boot.kernelModules = [
    "kvm-amd"
    "kvm-intel"
  ];

  networking.hostName = "aura";

  # Trust physical interfaces (virt bridges come from shared/virtualization.nix)
  networking.firewall.trustedInterfaces = [
    "enp1s0"
    "wlp2s0"
  ];

  # User groups (base groups come from nixos-common.nix, these are aura-specific)
  users.users.nbetm.extraGroups = [
    "docker"
    "incus-admin"
    "input"
    "kvm"
    "libvirtd"
    "networkmanager"
    "qemu-libvirtd"
    "uinput"
    "wheel"
  ];

  # Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Pass secret service
  services.passSecretService.enable = true;

  # Printing
  services.printing.enable = true;

  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      material-design-icons
    ];
  };

  # Audio (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Firefox
  programs.firefox.enable = true;

  # Packages
  environment.systemPackages = myLib.basePackages pkgs ++ myLib.linuxDesktopPackages pkgs;

  # HiDPI Overrides
  environment.variables = {
    QT_SCALE_FACTOR_ROUNDING_POLICY = "Round";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # Dropbox sync service
  systemd.user.services.dropbox = {
    description = "Dropbox";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${lib.getBin pkgs.dropbox}/bin/dropbox";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      Nice = 10;
    };
  };

  # xremap - macOS-style keyboard shortcuts
  hardware.uinput.enable = true;
  services.xremap = {
    enable = true;
    withKDE = true;
    serviceMode = "user";
    userName = "nbetm";
    yamlConfig = builtins.readFile ../../configs/xremap/xremap.yml;
  };

  systemd.user.services.xremap.serviceConfig = {
    NoNewPrivileges = true;
    MemoryDenyWriteExecute = true;
    RestrictRealtime = true;
    LockPersonality = true;
    RestrictAddressFamilies = [ "AF_UNIX" ];
  };

  system.stateVersion = "25.11";
}
