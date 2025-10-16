# Linux Desktop packages - GUI applications and desktop-specific tools
pkgs: with pkgs; [
  # Virtualization (system-level)
  libvirt
  virt-manager
  qemu_kvm
  (vagrant.override { withLibvirt = true; }) # Vagrant with libvirt support

  # Desktop Applications (Linux-only)
  dropbox
  enpass
  gnome-tweaks
  gnomeExtensions.appindicator
  kooha
  # nordic
  pass-wayland
  signal-desktop
  vesktop
  vim
  vivaldi
  wl-clipboard
  u.ghostty
  u.kitty
  u.zed-editor
  # u.zoom-us
  (pkgs.symlinkJoin {
    name = "zoom-us-hidpi";
    paths = [ u.zoom-us ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/zoom \
        --set QT_AUTO_SCREEN_SCALE_FACTOR 0 \
        --set QT_SCALE_FACTOR 1.2 \
        --set QT_SCREEN_SCALE_FACTORS 1.2 \
    '';
  })
]
