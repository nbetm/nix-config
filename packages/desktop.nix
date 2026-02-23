# Linux Desktop packages - GUI applications and desktop-specific tools
pkgs: with pkgs; [
  # Virtualization (system-level)
  libvirt
  virt-manager
  qemu_kvm
  (vagrant.override { withLibvirt = true; }) # Vagrant with libvirt support

  # Desktop Applications (Linux-only)
  u.klassy
  kdePackages.partitionmanager
  signal-desktop
  spotify
  vesktop
  wl-clipboard
  ghostty
  u.kitty
  u.vivaldi
  u.zed-editor

  # Password management (pass with extensions)
  (pass-wayland.withExtensions (exts: [
    exts.pass-audit
    exts.pass-import
    exts.pass-otp
    exts.pass-update
  ]))

  # Hacks
  (pkgs.symlinkJoin {
    name = "enpass-hidpi";
    paths = [ enpass ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/share/applications/enpass.desktop
      substitute ${enpass}/share/applications/enpass.desktop $out/share/applications/enpass.desktop \
        --replace-fail 'Exec=${enpass}/bin/Enpass' 'Exec=env QT_AUTO_SCREEN_SCALE_FACTOR=1 ${enpass}/bin/Enpass'
    '';
  })
  (pkgs.symlinkJoin {
    name = "zoom-us-hidpi";
    paths = [ u.zoom-us ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/zoom \
        --set QT_AUTO_SCREEN_SCALE_FACTOR 1 \
    '';
  })
]
