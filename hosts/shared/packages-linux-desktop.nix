# Linux Desktop packages - GUI applications and desktop-specific tools
pkgs: with pkgs; [
  # Terminals
  u.ghostty
  u.kitty

  # Browsers
  # Vivaldi: kwallet6 for browser-internal secrets; Qt wrap for Plasma 6 stability
  ((vivaldi.override { commandLineArgs = "--password-store=kwallet6"; }).overrideAttrs (oldAttrs: {
    dontWrapQtApps = false;
    dontPatchELF = true;
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
  }))
  vivaldi-ffmpeg-codecs

  # Communication
  signal-desktop
  (pkgs.symlinkJoin {
    name = "zoom-us-hidpi";
    paths = [ u.zoom-us ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/zoom \
        --set QT_AUTO_SCREEN_SCALE_FACTOR 1 \
        --set QT_SCALE_FACTOR_ROUNDING_POLICY Round
    '';
  })

  # Media
  spotify

  # Password management
  keepassxc
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
        --replace-fail 'Exec=${u.enpass}/bin/Enpass' 'Exec=env QT_AUTO_SCREEN_SCALE_FACTOR=1 QT_SCALE_FACTOR_ROUNDING_POLICY=Round ${u.enpass}/bin/Enpass'
    '';
  })

  # System
  flameshot
  kdePackages.partitionmanager
  kdiff3
  meld
  wl-clipboard
  xdg-utils

  # Icons
  papirus-icon-theme
]
