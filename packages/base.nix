# Base packages - Core CLI tools available on all systems
pkgs: with pkgs.u; [
  # Development Tools
  bash-language-server
  claude-code
  git
  helix
  neovim
  python313
  ruff
  uv

  # CLI Tools
  bat
  btop
  delta
  direnv
  fzf
  gh
  gitui
  jq
  just
  lazygit
  ripgrep
  sesh
  silver-searcher
  starship
  stow
  tmux
  tmux-xpanes
  tokei
  tree
  yazi
  yq
  zoxide

  # Language Servers & Formatters
  jinja-lsp
  marksman
  nixd
  nixfmt-rfc-style
  nixfmt-tree
  prettier
  pyright
  shellcheck
  taplo
  terraform-ls
  tflint
  vscode-json-languageserver
  yaml-language-server

  # Cloud & Infrastructure
  awscli2
  docker
  docker-language-server
  google-cloud-sdk
  google-cloud-sdk-gce
  nomad
  packer
  terraform

  # System Tools
  htop
  ipcalc
  neofetch
  parallel
  wget
  xdg-utils
]
