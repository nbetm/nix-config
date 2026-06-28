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
    ../shared/tailscale.nix
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

  # Tailscale: bastion + subnet router for the home LAN.
  myConfig.tailscale = {
    enable = true;
    advertiseRoutes = [ "192.168.1.0/24" ];
    lanInterfaces = [
      "enp1s0"
      "wlp2s0"
    ];
  };

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
  services.displayManager.plasma-login-manager.enable = true;
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
    # Firefox needs embedded bitmaps to render Noto Color Emoji
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      adwaita-fonts
      material-design-icons
      noto-fonts-color-emoji
      iosevka-n
      iosevka-n-term
      iosevka-n-quasi-proportional
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
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [
      pkgs.kdePackages.plasma-browser-integration
      pkgs.keepassxc
    ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFormHistory = true;
      EnableTrackingProtection = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
    };
  };

  programs._1password.enable = true;
  programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "nbetm" ];
  };

  # Packages
  environment.systemPackages =
    myLib.basePackages pkgs ++ myLib.linuxPackages pkgs ++ myLib.linuxDesktopPackages pkgs;

  # HiDPI Overrides
  environment.variables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
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
  # https://github.com/xremap/nix-flake
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
