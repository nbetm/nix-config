# Base packages - Core CLI tools available on all systems
pkgs: with pkgs; [
  # Development Tools
  git
  gcc
  u.claude-code
  u.helix
  u.neovim
  u.python313
  u.vim

  # CLI/TUI Tools
  zellij
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
  u.single-file-cli
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
  ansible-language-server
  u.ansible-lint
  u.bash-language-server
  u.jinja-lsp
  u.marksman
  u.nixd
  u.nixfmt-rfc-style
  u.nixfmt-tree
  u.prettier
  u.pyright
  u.ruff
  u.shellcheck
  u.shfmt
  u.taplo
  u.terraform-ls
  u.tflint
  u.uv
  u.vscode-json-languageserver
  u.yaml-language-server
  u.yamlfmt
  u.yamllint

  # Cloud & Infrastructure
  awscli2
  docker_28
  docker-compose-language-service
  docker-language-server
  u.google-cloud-sdk
  u.google-cloud-sdk-gce
  u.lazydocker
  u.nomad
  u.packer
  u.terraform

  # System Tools
  u.dnsutils
  u.htop
  u.ipcalc
  u.neofetch
  u.parallel
  u.wget
  u.xdg-utils
]
