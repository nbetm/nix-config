# Darwin/macOS specific packages
pkgs: with pkgs; [
  # GNU tool replacements (shadow macOS builtins)
  coreutils
  findutils
  gawk
  gnugrep
  gnused
  gnutar
  which # GNU which
  indent # GNU indent

  # Newer versions than macOS ships
  curl
  gnupg
  gzip
  less
  rsync

  # GUI apps
  u.kitty
]
