# Linux Desktop packages - GUI applications and desktop-specific tools
pkgs: with pkgs; [
  # Virtualization (system-level)
  libvirt
  virt-manager
  qemu_kvm
  (vagrant.override { withLibvirt = true; }) # Vagrant with libvirt support

  # Desktop Applications (Linux-only)
  (u.vivaldi.override {
    commandLineArgs = "--force-device-scale-factor=1.25";
  })
  u.zed-editor
  u.ghostty
  u.kitty
  u.kdePackages.krohnkite
  klassy # KDE window decoration and application style
  enpass
  pass-wayland
  qtpass
  maestral
  maestral-gui
  vesktop
  signal-desktop
  wl-clipboard # Wayland clipboard (Linux-only)
  vim # Keep basic vim on stable for system recovery
]
