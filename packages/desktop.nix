# Linux Desktop packages - GUI applications and desktop-specific tools
pkgs: with pkgs; [
  # Virtualization (system-level)
  libvirt
  virt-manager
  qemu_kvm
  (vagrant.override { withLibvirt = true; }) # Vagrant with libvirt support

  # Desktop Applications (Linux-only)
  u.vivaldi
  u.zed-editor
  u.ghostty
  u.kitty
  u.kdePackages.krohnkite
  klassy # KDE window decoration and application style
  (pkgs.symlinkJoin {
    name = "enpass-hidpi";
    paths = [ enpass ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/share/applications/enpass.desktop
      substitute ${enpass}/share/applications/enpass.desktop $out/share/applications/enpass.desktop \
        --replace-fail 'Exec=${enpass}/bin/Enpass' 'Exec=env QT_AUTO_SCREEN_SCALE_FACTOR=1 QT_SCALE_FACTOR=1.15 QT_SCREEN_SCALE_FACTORS=1.15 ${enpass}/bin/Enpass'
    '';
  })
  pass-wayland
  qtpass
  dropbox
  vesktop
  signal-desktop
  (pkgs.symlinkJoin {
    name = "zoom-us-hidpi";
    paths = [ u.zoom-us ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/zoom \
        --set QT_AUTO_SCREEN_SCALE_FACTOR 1 \
        --set QT_SCALE_FACTOR 1.15 \
        --set QT_SCREEN_SCALE_FACTORS 1.15 \
    '';
  })
  wl-clipboard # Wayland clipboard (Linux-only)
  vim # Keep basic vim on stable for system recovery
]
