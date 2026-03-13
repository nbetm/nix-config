# Andromeda - Headless NixOS VM (aarch64-linux)
# On-the-go dev alternative to aura, accessed via SSH.
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
  ];

  # ---------------------------------------------------------------------------
  # Nix Settings
  # ---------------------------------------------------------------------------
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # ---------------------------------------------------------------------------
  # System Basics
  # ---------------------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "andromeda";

  networking.networkmanager.enable = true;

  networking.nftables.enable = true;

  # Trust virtualization bridge interfaces
  networking.firewall.trustedInterfaces = [
    "incusbr0"
    "virbr0"
    "virbr1"
    "virbr2"
  ];

  # Don't let NetworkManager manage virt bridges
  networking.networkmanager.unmanaged = [
    "incusbr0"
    "virbr0"
    "virbr1"
    "virbr2"
  ];

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

  # ---------------------------------------------------------------------------
  # User
  # ---------------------------------------------------------------------------
  users.users.nbetm = {
    isNormalUser = true;
    description = "Nelson Monserrate";
    extraGroups = [
      "docker"
      "incus-admin"
      "kvm"
      "libvirtd"
      "qemu-libvirtd"
      "wheel"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICR+Am/2drHgOPkf0pzogA8SRcNhJsdVMDEvfDIrOauO nbetm@localhost"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  # ---------------------------------------------------------------------------
  # Programs
  # ---------------------------------------------------------------------------
  programs.ssh.startAgent = true;

  programs.bash = {
    enable = true;
    completion.enable = true;
  };

  programs.zsh.enable = true;

  programs.direnv.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # ---------------------------------------------------------------------------
  # Environment
  # ---------------------------------------------------------------------------
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    LIBVIRT_DEFAULT_URI = "qemu:///system";
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
    UV_PYTHON_DOWNLOADS = "never";
  };

  environment.localBinInPath = true;

  environment.systemPackages = myLib.basePackages pkgs ++ [
    pkgs.gnumake
    pkgs.libvirt
    (pkgs.vagrant.override { withLibvirt = true; })
  ];

  # ---------------------------------------------------------------------------
  # Services
  # ---------------------------------------------------------------------------
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # ---------------------------------------------------------------------------
  # Virtualisation
  # ---------------------------------------------------------------------------
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
      };
      onBoot = "start";
      onShutdown = "shutdown";
    };

    incus = {
      enable = true;
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

  # ---------------------------------------------------------------------------
  # State
  # ---------------------------------------------------------------------------
  system.stateVersion = "25.11";
}
