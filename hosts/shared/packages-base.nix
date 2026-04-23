# Base packages - Core CLI tools available on all systems
pkgs: with pkgs; [
  # Editors
  claude-code
  helix
  u.neovim
  vim

  # Shell
  bash-completion
  starship
  zsh-autosuggestions
  zsh-fast-syntax-highlighting

  # CLI/TUI Tools
  asciinema_3
  awscli2
  bat
  btop
  delta
  docker-buildx
  doitlive
  fd
  ffmpeg
  fzf
  gh
  u.gh-dash
  git
  glow
  google-cloud-sdk
  jq
  just
  lazydocker
  lazygit
  ncdu
  pandoc
  ripgrep
  sesh
  silver-searcher
  single-file-cli
  spotdl
  stow
  tmux
  tmux-xpanes
  tokei
  tree
  yazi
  yq
  yt-dlp
  u.zellij
  zoxide

  # Ansible
  ansible-lint
  jinja-lsp

  # Bash
  bash-language-server
  shellcheck
  shfmt

  # Docker
  docker-language-server
  dockerfmt
  hadolint

  # JSON
  vscode-json-languageserver

  # Lua
  lua-language-server
  luajit
  selene
  stylua

  # Markdown
  marksman
  prettier

  # Nix
  nixd
  nixfmt-rfc-style
  nixfmt-tree

  # Python
  python313
  python313Packages.weasyprint
  u.pyright
  u.ruff
  u.uv

  # TOML
  taplo

  # YAML
  yaml-language-server
  yamlfmt
  yamllint

  # Fonts
  nerd-fonts.symbols-only

  # System Tools
  dnsutils
  fastfetch
  gnumake
  graphviz
  htop
  imagemagick
  ipcalc
  parallel
  watch
  wget
]
