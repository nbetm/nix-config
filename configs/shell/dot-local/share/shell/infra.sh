# shellcheck shell=bash disable=SC1091
# Infrastructure tools - Python, AWS, Terraform, Nomad, Ansible

# ------------------------------------------------------------------------------
# Python / pip
# ------------------------------------------------------------------------------

alias venvrm="find . -name .venv -type d -print0 | xargs -0 rm -fr"

# ------------------------------------------------------------------------------
# uv (Python package manager)
# ------------------------------------------------------------------------------

uv-python-symlinks() {
    # Creates symlinks in $HOME/.local/bin for python versions installed with uv
    # https://github.com/willkg/dotfiles/blob/main/dotfiles/bin/uv-python-symlink

    local LOCALBIN="${HOME}/.local/bin"
    local UVDIR
    UVDIR=$(uv python dir)

    # Create symlinks for pythonX.Y to uv-managed Pythons
    for ITEM in "${UVDIR}"/*; do
        local BASEITEM FULLVERSION MINORVERSION DEST
        BASEITEM=$(basename "${ITEM}")
        FULLVERSION=$(echo "${BASEITEM}" | cut -d "-" -f 2)
        MINORVERSION=$(echo "${FULLVERSION}" | rev | cut -f 2- -d "." | rev)
        DEST="${LOCALBIN}/python${MINORVERSION}"

        if [[ -L "${DEST}" ]]; then
            if [[ -e "${DEST}" ]]; then
                echo "${DEST} already exists and is valid. Nothing to do."
                continue
            else
                echo "${DEST} already exists but is broken. Removing."
                rm "${DEST}"
            fi
        fi

        ln -sf "${UVDIR}/${BASEITEM}/bin/python${MINORVERSION}" "${DEST}"
        echo "${DEST} created."
    done

    # Create symlink for python to latest uv-managed Python
    local LATESTPYTHON DEST
    LATESTPYTHON=$(uv python find)
    DEST="${LOCALBIN}/python"

    if [[ -L "${DEST}" ]]; then
        if [[ -e "${DEST}" ]]; then
            echo "${DEST} already exists and is valid. Nothing to do."
        else
            echo "${DEST} already exists but is broken. Removing."
            rm "${DEST}"
        fi
    fi

    ln -sf "${LATESTPYTHON}" "${DEST}"
    echo "${DEST} created."
}

# ------------------------------------------------------------------------------
# AWS
# ------------------------------------------------------------------------------

alias awspu="unset AWS_PROFILE"

# Pick a profile from ~/.aws/config with fzf (falls back to "default")
_aws_pick() {
    if [[ -f ~/.aws/config ]]; then
        sed -nr "s/^\[profile (.+)\]$/\1/p" ~/.aws/config | fzf
    else
        echo "default"
    fi
}

# Set the active profile (no login)
awsp() {
    local choice
    choice=$(_aws_pick)
    [[ -n "$choice" ]] && export AWS_PROFILE="$choice"
}

# SSO login, set the active profile, then refresh read-only container creds
awsl() {
    local choice
    choice=$(_aws_pick)
    [[ -z "$choice" ]] && return

    if [[ -n "$SSH_TTY" ]]; then
        aws sso login --no-browser --profile "$choice" || return
    else
        aws sso login --profile "$choice" || return
    fi

    export AWS_PROFILE="$choice"

    # px-systems logins refresh the staged read-only creds for agent containers
    [[ "$choice" == px-* ]] && command -v awsro >/dev/null && awsro
}

# ------------------------------------------------------------------------------
# Terraform
# ------------------------------------------------------------------------------

alias tf="terraform"
alias tfi="terraform init"
alias tfiu="terraform init -upgrade"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfar="terraform apply -refresh-only"
alias tfw="terraform workspace"
alias tfwl="terraform workspace list"
alias tfwn="terraform workspace new"
alias tfws="terraform workspace select"
alias tffmt="terraform fmt"
alias tfs="terraform state"
alias tfsl="terraform state list"
alias tfdestroy="terraform destroy"
alias tfprovlock="terraform providers lock -platform darwin_arm64 -platform darwin_amd64 -platform linux_amd64"
alias tflocalrm="find . -name .terraform -type d -print0 | xargs -0 rm -fr"

# ------------------------------------------------------------------------------
# Nomad
# ------------------------------------------------------------------------------

alias nm="nomad"

# ------------------------------------------------------------------------------
# Ansible
# ------------------------------------------------------------------------------

alias ans="ansible"
alias ansp="ansible-playbook --diff"
alias anspc="ansible-playbook --diff --check"

# ------------------------------------------------------------------------------
# Agent sandbox (Incus dev containers)
# ------------------------------------------------------------------------------

alias asb="agent-sandbox build-image"
alias asc="agent-sandbox create"
alias ase="agent-sandbox enter"
alias asr="agent-sandbox restart"
alias ass="agent-sandbox stop"
alias asu="agent-sandbox update"
alias asd="agent-sandbox destroy"
alias asl="agent-sandbox list"
