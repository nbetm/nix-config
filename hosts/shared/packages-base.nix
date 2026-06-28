# Base packages - Core CLI tools available on all systems
pkgs: with pkgs; [
  # AI coding agents (via llm-agents.nix overlay for fresher releases)
  llm-agents.claude-code
  # llm-agents.codex
  # llm-agents.gemini-cli

  # Editors
  helix
  neovim
  vim

  # Shell
  bash-completion
  blesh
  complete-alias
  starship
  zsh-autosuggestions
  zsh-fast-syntax-highlighting

  # CLI/TUI Tools
  asciinema
  awscli2
  bat
  bats
  btop
  delta
  docker-buildx
  doitlive
  fd
  ffmpeg
  fzf
  gh
  gh-dash
  git
  glow
  google-cloud-sdk
  jjui
  jq
  jujutsu
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
  tree-sitter
  yazi
  yq-go
  yt-dlp
  zellij
  zoxide

  # Ansible
  ansible-lint
  ansible-language-server
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
  python314Packages.mdformat
  python314Packages.mdformat-frontmatter
  python314Packages.mdformat-gfm

  # Nix
  nixd
  nixfmt
  nixfmt-tree

  # Python
  python314
  python314Packages.weasyprint
  pyright
  ruff
  uv

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
