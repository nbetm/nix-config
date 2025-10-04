# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{
  config,
  pkgs,
  lib,
  myLib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # KVM kernel modules
  boot.kernelModules = [
    "kvm-amd"
    "kvm-intel"
  ];

  networking.hostName = "aura"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Trust libvirt bridge interfaces for VM networking (required for Vagrant DHCP)
  networking.firewall.trustedInterfaces = [
    "virbr0"
    "virbr1"
    "virbr2"
  ];

  # Don't let NetworkManager manage libvirt bridges (prevents conflicts)
  networking.networkmanager.unmanaged = [
    "virbr0"
    "virbr1"
    "virbr2"
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Use nftables
  networking.nftables.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Fonts
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # nerd fonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only # symbols icon only
    ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nbetm = {
    isNormalUser = true;
    description = "Nelson Monserrate";
    extraGroups = [
      "networkmanager"
      "wheel"
      "qemu-libvirtd"
      "docker"
      "libvirtd"
      "kvm"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICR+Am/2drHgOPkf0pzogA8SRcNhJsdVMDEvfDIrOauO nbetm@localhost"
    ];
    # packages = with pkgs; [
    #   kdePackages.kate
    #  thunderbird
    # ];
  };

  # Whether users of the wheel group must provide a password to run commands via sudo
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # SSH Agent
  programs.ssh.startAgent = true;

  # Install zsh
  programs.zsh.enable = true;

  # Install firefox
  programs.firefox.enable = true;

  # Install neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # Set the default editor to vim
  environment.variables.EDITOR = "hx";
  environment.variables.VISUAL = "hx";

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Shared packages for consistent development environment across all systems
  environment.systemPackages =
    myLib.basePackages pkgs
    ++ myLib.desktopPackages pkgs
    ++ [
      # Additional NixOS system packages
      pkgs.gnumake # Keep make on stable for system builds
    ];

  # Disable uv python downloads
  environment.variables.UV_PYTHON_DOWNLOADS = "never";

  # Libvirt + Vagrant
  environment.variables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
    # HiDPI scaling for Qt/KDE apps
    PLASMA_USE_QT_SCALING = "1";
    # HiDPI scaling for GTK apps (matches KDE's scaling)
    # GDK_SCALE = "1";
    # GDK_DPI_SCALE = "1.25";
    # Electron apps (Slack, Discord, etc)
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Virtualisation stuff I want enabled
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    # Enable libvirtd for virtualization (KVM/QEMU with Vagrant support)
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
      onBoot = "start"; # Auto-start networks on boot
      onShutdown = "shutdown"; # Proper shutdown handling
    };

    # Enable incus for easier
    incus = {
      enable = true;
      # Incus preseed values. Copied from the wiki page https://wiki.nixos.org/wiki/Incus
      # They all seemed to match what I needed.
      preseed = {
        networks = [
          {
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat" = "true";
            };
            name = "incusbr0";
            type = "bridge";
          }
        ];
        profiles = [
          {
            devices = {
              eth0 = {
                name = "eth0";
                network = "incusbr0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                size = "35GiB";
                type = "disk";
              };
            };
            name = "default";
          }
        ];
        storage_pools = [
          {
            config = {
              source = "/var/lib/incus/storage-pools/default";
            };
            driver = "dir";
            name = "default";
          }
        ];
      };
    };
  };

  # Maestral Dropbox sync service
  systemd.user.services.maestral = {
    description = "Maestral Dropbox sync";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "notify";
      NotifyAccess = "exec";
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      WatchdogSec = "30s";
      Restart = "on-failure";
      RestartSec = "3s";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
