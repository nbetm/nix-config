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
  less
  gnumake
  rsync
  gzip
  gnupg

  # CLI tools not in base.nix
  fd
  glow
  ncdu
  tig
  watch
  cmake

  # Language servers (Lua editing on Mac — nvim config, etc.)
  lua-language-server
  stylua

  # GUI apps / cask replacements
  u.kitty
  nerd-fonts.symbols-only

  # Occasional-use tools
  imagemagick
  graphviz
]
