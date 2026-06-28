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

  # incusd (root) needs a subuid/subgid grant covering 1000 so the
  # agent-sandbox profile's `raw.idmap uid/gid 1000 1000` is permitted by
  # newuidmap. The incus module already grants root the large 1000000+ range
  # (see /etc/subuid); this appends the single id 1000 it's missing.
  users.users.root.subUidRanges = [
    {
      startUid = 1000;
      count = 1;
    }
  ];
  users.users.root.subGidRanges = [
    {
      startGid = 1000;
      count = 1;
    }
  ];

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
              "ipv4.dhcp.ranges" = "10.0.100.100-10.0.100.250";
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
                size = "35GiB";
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
