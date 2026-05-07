# vim: set ft=sh :
# shellcheck shell=bash disable=SC1091
# Tool aliases and functions - SSH, tmux, editors, system utilities

# ------------------------------------------------------------------------------
# SSH
# ------------------------------------------------------------------------------

alias s="ssh"
alias ssha="ssh-add -l"
alias sshar="ssh-add -D && ssh-add ~/.ssh/id_ed25519-nbetm ~/.ssh/id_ed25519-nbetm-gh"
alias sshaD="ssh-add -D"

# ------------------------------------------------------------------------------
# Tmux
# ------------------------------------------------------------------------------

alias t="tmux"
alias tsn="tmux new -As"
alias tsl="tmux list-sessions"
alias tsk="tmux kill-session"
alias tska="tmux kill-session -a"
alias twr='tmux renamew $(basename "$(pwd)")'

# ------------------------------------------------------------------------------
# Editors
# ------------------------------------------------------------------------------

alias n="nvim"

# ------------------------------------------------------------------------------
# Claude
# ------------------------------------------------------------------------------

alias c="claude"

# ------------------------------------------------------------------------------
# File Managers
# ------------------------------------------------------------------------------

alias yz="yazi"
alias lzd="lazydocker"

# ------------------------------------------------------------------------------
# Xpanes
# ------------------------------------------------------------------------------

alias xpssh="xpanes -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpsshv="xpanes -l ev -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpsshh="xpanes -l eh -s -c 'ssh -o StrictHostKeyChecking=no {}'"
alias xpping="xpanes -s -c 'ping -n {}'"
alias xppingv="xpanes -l ev -s -c 'ping -n {}'"
alias xppingh="xpanes -l eh -s -c 'ping -n {}'"

# ------------------------------------------------------------------------------
# Markdown to PDF
# ------------------------------------------------------------------------------

md2pdf() {
    pandoc "$1" -o "${1%.md}.pdf" --pdf-engine=weasyprint \
        --css="$XDG_CONFIG_HOME"/md2pdf.css
}
