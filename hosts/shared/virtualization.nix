{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Use nftables
  networking.nftables.enable = true;

  # Trust libvirt bridge interfaces for VM networking
  networking.firewall.trustedInterfaces = [
    "incusbr0"
    "virbr0"
    "virbr1"
    "virbr2"
    "docker0"
  ];

  # Don't let NetworkManager manage virt bridges (prevents conflicts)
  networking.networkmanager.unmanaged = [
    "incusbr0"
    "virbr0"
    "virbr1"
    "virbr2"
  ];

  environment.variables.LIBVIRT_DEFAULT_URI = "qemu:///system";

  virtualisation = {
    docker = {
      enable = true;
      package = pkgs.docker_29;
      daemon.settings = {
        userns-remap = "nbetm:nbetm";
      };
    };

    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
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
          {
            name = "agent-sandbox";
            description = "Sandbox for Claude Code with nested Docker";
            config = {
              "security.nesting" = "true";
              "security.syscalls.intercept.mknod" = "true";
              "security.syscalls.intercept.setxattr" = "true";
              "linux.kernel_modules" = "tun";
              "raw.idmap" = ''
                uid 1000 1000
                gid 1000 1000
              '';
            };
            devices = {
              eth0 = {
                name = "eth0";
                network = "incusbr0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                type = "disk";
              };
            };
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
}
