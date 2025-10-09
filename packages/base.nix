# Base packages - Core CLI tools available on all systems
pkgs: with pkgs; [
  # Development Tools
  git
  u.bash-language-server
  u.claude-code
  u.helix
  u.neovim
  u.python313
  u.ruff
  u.uv

  # CLI Tools
  u.bat
  u.btop
  u.delta
  u.direnv
  u.fzf
  u.gh
  u.gitui
  u.jq
  u.just
  u.lazygit
  u.ripgrep
  u.sesh
  u.silver-searcher
  u.starship
  u.stow
  u.tmux
  u.tmux-xpanes
  u.tokei
  u.tree
  u.yazi
  u.yq
  u.zoxide

  # Language Servers & Formatters
  u.jinja-lsp
  u.marksman
  u.nixd
  u.nixfmt-rfc-style
  u.nixfmt-tree
  u.prettier
  u.pyright
  u.shellcheck
  u.taplo
  u.terraform-ls
  u.tflint
  u.vscode-json-languageserver
  u.yaml-language-server

  # Cloud & Infrastructure
  awscli2
  docker_28
  nomad
  packer
  terraform
  u.docker-language-server
  u.google-cloud-sdk
  u.google-cloud-sdk-gce
  u.lazydocker

  # System Tools
  u.htop
  u.ipcalc
  u.neofetch
  u.parallel
  u.wget
  u.xdg-utils
]
