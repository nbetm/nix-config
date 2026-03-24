# Home-manager config shared across all hosts.
# Used purely as a symlink engine — no programs.<tool>.enable.
{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  # Shell dotfiles
  home.file = {
    ".zshrc".source = ../../configs/shell/dot-zshrc;
    ".bashrc".source = ../../configs/shell/dot-bashrc;
    ".bash_profile".source = ../../configs/shell/dot-bash_profile;
    ".zshenv".source = ../../configs/shell/dot-zshenv;
    ".zprofile".source = ../../configs/shell/dot-zprofile;
    ".blerc".source = ../../configs/shell/dot-blerc;
    ".dir_colors".source = ../../configs/shell/dot-dir_colors;
    ".direnvrc".source = ../../configs/shell/dot-direnvrc;
    ".gitconfig".source = ../../configs/git/dot-gitconfig;
    ".gitignore".source = ../../configs/git/dot-gitignore;

    # Shell scripts and bins
    ".local/bin/ytdl".source = ../../configs/shell/dot-local/bin/ytdl;
    ".local/share/shell" = {
      source = ../../configs/shell/dot-local/share/shell;
      recursive = true;
    };

    # Tmux
    ".local/bin/sesh-picker".source = ../../configs/tmux/dot-local/bin/sesh-picker;
    ".local/bin/tmux-toggle-side-pane".source = ../../configs/tmux/dot-local/bin/tmux-toggle-side-pane;
    ".local/bin/tmux-toggle-float-session".source =
      ../../configs/tmux/dot-local/bin/tmux-toggle-float-session;
    ".local/bin/tmux-cleanup-float-session".source =
      ../../configs/tmux/dot-local/bin/tmux-cleanup-float-session;
    ".local/bin/tmux-open-url".source = ../../configs/tmux/dot-local/bin/tmux-open-url;

    # ZSH completions (manual — not provided by nix packages)
    ".zsh/completions" = {
      source = ../../configs/shell/dot-zsh/completions;
      recursive = true;
    };

    # ZSH plugins
    ".zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    ".zsh/plugins/fast-syntax-highlighting".source =
      "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting";
  };

  # XDG config files
  xdg.configFile = {
    "bat" = {
      source = ../../configs/bat/dot-config/bat;
      recursive = true;
    };
    "btop" = {
      source = ../../configs/btop/dot-config/btop;
      recursive = true;
    };
    "delta".source = ../../configs/delta/dot-config/delta;
    "helix" = {
      source = ../../configs/helix/dot-config/helix;
      recursive = true;
    };
    "lazygit".source = ../../configs/git/dot-config/lazygit;
    "md2pdf.css".source = ../../configs/shell/dot-config/md2pdf.css;
    "ncdu".source = ../../configs/ncdu/dot-config/ncdu;
    "sesh".source = ../../configs/sesh/dot-config/sesh;
    "starship.toml".source = ../../configs/starship/dot-config/starship.toml;
    "tmux" = {
      source = ../../configs/tmux/dot-config/tmux;
      recursive = true;
    };
    "yamlfmt".source = ../../configs/yamlfmt/dot-config/yamlfmt;
    "yazi" = {
      source = ../../configs/yazi/dot-config/yazi;
      recursive = true;
    };
    "yazi/flavors/tmtheme.xml".source = ../../configs/bat/dot-config/bat/themes/nord-deep.tmTheme;
  };
}
