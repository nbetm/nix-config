# shellcheck shell=bash disable=SC1091
# VCS aliases — git + jj, inspired by prezto's git module.
# https://github.com/sorin-ionescu/prezto/blob/master/modules/git/alias.zsh
#
# Dual functions (gco, gp, gf, gfa, glg, gws, gwd, gcs, gba, gt, gr) dispatch
# to jj when .jj/ is present in the repo root, else fall back to git.

# ------------------------------------------------------------------------------
# Log Formats
# ------------------------------------------------------------------------------

_git_log_medium_format="%C(bold)Commit:%C(reset) %C(green)%H%C(bold magenta)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%w(80,1,2)%+B"
_git_log_oneline_format="%C(green)%h%C(reset) %C(blue)%ad%C(reset) %C(cyan)%an%C(reset) %C(bold magenta)%d%C(reset) %s"
_git_log_brief_format="%C(green)%h%C(reset) %C(blue)(%ar by %C(cyan)%an%C(blue))%C(bold magenta)%d%C(reset) %n%s%n"
_git_status_ignore_submodules="none"

# ------------------------------------------------------------------------------
# Git / Jujutsu / TUI
# ------------------------------------------------------------------------------

alias g="git"
alias lzg="lazygit"
alias j="jj"
alias jui="jjui"

alias jgi="jj git init && jj bookmark track main"

# ------------------------------------------------------------------------------
# Branch (b)
# ------------------------------------------------------------------------------

gb() {
    if [[ -d .jj ]]; then
        jj bookmark list
    else
        git branch
    fi
}

gba() {
    if [[ -d .jj ]]; then
        jj bookmark list --all-remotes
    else
        git branch --all
    fi
}

alias gbd="git branch --delete"
alias gbD="git branch --delete --force"
alias gbm="git branch --move"
alias gbM="git branch --move --force"
alias gbs="git show-branch"
alias gbsa="git show-branch --all"

# ------------------------------------------------------------------------------
# Commit (c)
# ------------------------------------------------------------------------------

gco() {
    if [[ -d .jj ]]; then
        jj new "$1"
    else
        git checkout "$1"
    fi
}

gcs() {
    if [[ -d .jj ]]; then
        jj diff -r "$1"
    else
        git show "$1"
    fi
}

alias gc="git commit --verbose"
alias gca="git commit --verbose --all"
alias gcm="git commit --message"
alias gcam="git commit --all --message"
alias gcO="git checkout --patch"
alias gcf="git commit --amend --reuse-message HEAD"
alias gcF="git commit --verbose --amend"
alias gcr="git revert"
alias gcR='git reset "HEAD^"'
alias gcl="git-commit-lost"

# ------------------------------------------------------------------------------
# Conflict (C)
# ------------------------------------------------------------------------------

alias gCl="git --no-pager diff --name-only --diff-filter=U"
alias gCa='git add $(gCl)'
alias gCe='git mergetool $(gCl)'
alias gCo="git checkout --ours --"
alias gCO='gCo $(gCl)'
alias gCt="git checkout --theirs --"
alias gCT='gCt $(gCl)'

# ------------------------------------------------------------------------------
# Data (d)
# ------------------------------------------------------------------------------

alias gd="git ls-files"
alias gdc="git ls-files --cached"
alias gdd="git ls-files --deleted"
alias gdm="git ls-files --modified"
alias gdu="git ls-files --other --exclude-standard"

# ------------------------------------------------------------------------------
# Fetch (f)
# ------------------------------------------------------------------------------

gf() {
    if [[ -d .jj ]]; then
        jj git fetch
    else
        git fetch
    fi
}

gfa() {
    if [[ -d .jj ]]; then
        jj git fetch --all-remotes
    else
        git fetch --all --prune --tags
    fi
}

alias gfc="git clone"
alias gfcr="git clone --recurse-submodules"
alias gfm="git pull"
alias gfma="git pull --autostash"
alias gfr="git pull --rebase"
alias gfra="git pull --rebase --autostash"

# ------------------------------------------------------------------------------
# Grep (g)
# ------------------------------------------------------------------------------

alias gg="git grep"
alias ggi="git grep --ignore-case"
alias ggl="git grep --files-with-matches"
alias ggL="git grep --files-without-matches"
alias ggv="git grep --invert-match"
alias ggw="git grep --word-regexp"

# ------------------------------------------------------------------------------
# Index (i)
# ------------------------------------------------------------------------------

alias gia="git add"
alias giu="git add --update"
alias gid="git diff --no-ext-diff --cached"
alias gir="git reset"
alias giR="git reset --patch"

# ------------------------------------------------------------------------------
# Log (l)
# ------------------------------------------------------------------------------

glg() {
    if [[ -d .jj ]]; then
        jj log
    else
        git log --topo-order --all --graph --date=local --pretty=format:"$_git_log_oneline_format"
    fi
}

alias gl='git log --topo-order --pretty=format:"$_git_log_medium_format"'
alias gls='git log --topo-order --stat --pretty=format:"$_git_log_medium_format"'
alias glo='git log --topo-order --pretty=format:"$_git_log_oneline_format"'

# ------------------------------------------------------------------------------
# Merge (m)
# ------------------------------------------------------------------------------

alias gm="git merge"
alias gmC="git merge --no-commit"
alias gmF="git merge --no-ff"
alias gma="git merge --abort"
alias gmt="git mergetool"

# ------------------------------------------------------------------------------
# Push (p)
# ------------------------------------------------------------------------------

gp() {
    if [[ -d .jj ]]; then
        jj git push
    else
        git push
    fi
}

alias gpf="git push --force-with-lease"
alias gpF="git push --force"
alias gpt="git push --tags"

# ------------------------------------------------------------------------------
# Rebase (r)
# ------------------------------------------------------------------------------

alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gri="git rebase --interactive"
alias grs="git rebase --skip"

# ------------------------------------------------------------------------------
# Remote (R)
# ------------------------------------------------------------------------------

alias gR="git remote"
alias gRl="git remote --verbose"

# ------------------------------------------------------------------------------
# Stash (s)
# ------------------------------------------------------------------------------

alias gs="git stash"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gss="git stash push --include-untracked"

# ------------------------------------------------------------------------------
# Tag (t)
# ------------------------------------------------------------------------------

gt() {
    if [[ -d .jj ]]; then
        jj tag list
    else
        git tag
    fi
}

# ------------------------------------------------------------------------------
# Working Copy (w)
# ------------------------------------------------------------------------------

gws() {
    if [[ -d .jj ]]; then
        jj st
    else
        git status --ignore-submodules=$_git_status_ignore_submodules --short
    fi
}

gwd() {
    if [[ -d .jj ]]; then
        jj diff
    else
        git diff --no-ext-diff
    fi
}

alias gwS='git status --ignore-submodules=$_git_status_ignore_submodules'
alias gwD="git diff --no-ext-diff --word-diff"
alias gwc="git clean --dry-run"
alias gwC="git clean --force"
