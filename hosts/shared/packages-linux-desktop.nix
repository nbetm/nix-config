# Linux Desktop packages - GUI applications and desktop-specific tools
pkgs: with pkgs; [
  # Terminals
  u.ghostty
  u.kitty

  # Browsers
  u.vivaldi

  # Communication
  signal-desktop
  (pkgs.symlinkJoin {
    name = "zoom-us-hidpi";
    paths = [ u.zoom-us ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/zoom \
        --set QT_AUTO_SCREEN_SCALE_FACTOR 1 \
    '';
  })

  # Media
  spotify

  # Password management
  (pass-wayland.withExtensions (exts: [
    exts.pass-audit
    exts.pass-import
    exts.pass-otp
    exts.pass-update
  ]))
  (pkgs.symlinkJoin {
    name = "enpass-hidpi";
    paths = [ u.enpass ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/share/applications/enpass.desktop
      substitute ${u.enpass}/share/applications/enpass.desktop $out/share/applications/enpass.desktop \
        --replace-fail 'Exec=${u.enpass}/bin/Enpass' 'Exec=env QT_AUTO_SCREEN_SCALE_FACTOR=1 ${u.enpass}/bin/Enpass'
    '';
  })

  # System
  kdePackages.partitionmanager
  wl-clipboard
  xdg-utils

  # Icons
  papirus-icon-theme
]
