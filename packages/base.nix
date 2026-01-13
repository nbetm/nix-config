# Base packages - Core CLI tools available on all systems
pkgs: with pkgs; [
  # Development Tools
  git
  gcc
  helix
  neovim
  python313
  vim
  u.claude-code

  # CLI/TUI Tools
  asciinema_3
  bash-completion
  bat
  blesh
  btop
  delta
  direnv
  doitlive
  fzf
  gh
  gitui
  jq
  just
  lazygit
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
  zellij
  zoxide

  # Language Servers & Formatters
  ansible-lint
  bash-language-server
  jinja-lsp
  marksman
  nixd
  nixfmt-rfc-style
  nixfmt-tree
  prettier
  pyright
  ruff
  shellcheck
  shfmt
  taplo
  terraform-ls
  tflint
  uv
  vscode-json-languageserver
  yaml-language-server
  yamlfmt
  yamllint

  # Cloud & Infrastructure
  awscli2
  docker_28
  docker-compose-language-service
  docker-language-server
  google-cloud-sdk
  google-cloud-sdk-gce
  lazydocker
  nomad
  packer
  terraform

  # System Tools
  dnsutils
  htop
  ipcalc
  neofetch
  parallel
  wget
  xdg-utils
]
