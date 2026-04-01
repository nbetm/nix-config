# Base packages - Core CLI tools available on all systems
pkgs: with pkgs; [
  # Development Tools
  claude-code
  gcc
  git
  helix
  neovim
  python313
  vim

  # CLI/TUI Tools
  asciinema_3
  bash-completion
  bat
  btop
  delta
  doitlive
  ffmpeg
  fd
  fzf
  gh
  glow
  jq
  just
  lazygit
  ncdu
  pandoc
  python313Packages.weasyprint
  ripgrep
  sesh
  silver-searcher
  single-file-cli
  spotdl
  starship
  stow
  tmux
  tmux-xpanes
  tokei
  tree
  yazi
  yq
  yt-dlp
  zellij
  zoxide

  # Zsh plugins
  zsh-autosuggestions
  zsh-fast-syntax-highlighting

  # Language Servers & Formatters
  ansible-lint
  bash-language-server
  lua-language-server
  jinja-lsp
  marksman
  nixd
  nixfmt-rfc-style
  nixfmt-tree
  prettier
  u.pyright
  u.ruff
  u.shellcheck
  u.shfmt
  u.stylua
  taplo
  terraform-ls
  tflint
  u.uv
  vscode-json-languageserver
  u.yaml-language-server
  yamlfmt
  yamllint

  # Cloud & Infrastructure
  awscli2
  docker-compose-language-service
  docker-language-server
  docker_28
  google-cloud-sdk
  lazydocker
  nomad
  packer
  terraform

  # Fonts
  nerd-fonts.symbols-only

  # System Tools
  dnsutils
  graphviz
  fastfetch
  gnumake
  htop
  imagemagick
  ipcalc
  nvd
  parallel
  watch
  wget
  xdg-utils
]
