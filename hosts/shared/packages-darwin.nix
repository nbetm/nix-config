# Darwin/macOS specific packages
pkgs: with pkgs; [
  # GNU tool replacements (shadow macOS builtins)
  #
  # coreutils minus stty: XNU sets PENDIN whenever ICANON is turned on, so GNU
  # stty's post-write memcmp always trips — once per command under ble.sh. Let
  # BSD /bin/stty win; GNU's is still at `coreutils --coreutils-prog=stty`.
  (symlinkJoin {
    name = "coreutils-no-stty";
    paths = [ coreutils ];
    postBuild = "rm -f $out/bin/stty";
  })
  findutils
  gawk
  gnugrep
  gnused
  gnutar
  which
  indent

  # Newer versions than macOS ships
  curl
  gnupg
  gzip
  less
  rsync

  # Docker (via Colima on macOS)
  colima
  docker-client

  # GUI apps
  flameshot
  u.kitty
]
