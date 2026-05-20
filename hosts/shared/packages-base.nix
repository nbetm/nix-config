# Base packages - Core CLI tools available on all systems
pkgs: with pkgs; [
  # Editors
  u.claude-code
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
  u.jujutsu
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
  u.tree-sitter
  yazi
  yq-go
  yt-dlp
  u.zellij
  zoxide

  # Ansible
  ansible-lint
  u.ansible-language-server
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
  u.python313Packages.mdformat
  u.python313Packages.mdformat-frontmatter
  u.python313Packages.mdformat-gfm

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
