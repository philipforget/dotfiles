#!/usr/bin/env bash

# Tell bash to fail immediately on any error as well as unset variables
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

symlink() {
    local SOURCE="${1}"
    local TARGET="${2}"

    # Make sure the parent folder exists before creating the symklink
    mkdir -p "$(dirname ${TARGET})"

    ln -s "${SOURCE}" "${TARGET}"
}

# Se up the dotfiles repository
setup_dotfiles() {
    local readonly WORKSPACE="${HOME}/workspace"
    local readonly DOTFILES="${WORKSPACE}/dotfiles"
    mkdir -p "${WORKSPACE}"

    if [[ -d "${DOTFILES}" ]]; then
        echo "dotfiles already cloned, skipping"
    else
        git clone https://github.com/philipforget/dotfiles.git "${DOTFILES}"
    fi

    # Set up symlinks
    symlink "${DOTFILES}/aliases" ~/.aliases
    symlink "${DOTFILES}/aliases_linux" ~/.aliases_linux
    symlink "${DOTFILES}/aliases_mac" ~/.aliases_mac
    symlink "${DOTFILES}/bash_custom" ~/.bash_custom
    symlink "${DOTFILES}/bash_linux" ~/.bash_linux
    symlink "${DOTFILES}/bash_mac" ~/.bash_mac
    symlink "${DOTFILES}/distraction" ~/.distraction
    symlink "${DOTFILES}/docker_config.json" ~/.docker/config.json
    symlink "${DOTFILES}/gitconfig" ~/.gitconfig
    symlink "${DOTFILES}/pylintrc" ~/.pylintrc
    symlink "${DOTFILES}/tmux.conf" ~/.tmux.conf
    symlink "${DOTFILES}/vim" ~/.config/nvim
    symlink "${DOTFILES}/vim" ~/.vim
    symlink "${DOTFILES}/vim/init.vim" ~/.vimrc
    symlink "${DOTFILES}/xmodmap" ~/.xmodmap

    # Mac only symlinks
    if [[ $(uname) == "Darwin" ]]; then
        symlink "${DOTFILES}/Shortcuts.json" "~/Library/Application Support/Spectacle/Shortcuts.json"
    fi

    if ! grep -Fxq 'source ~/.bash_custom' "${HOME}/.bashrc"; then
        echo 'source ~/.bash_custom' >> "${HOME}/.bashrc"
    fi
}

setup_virtualenv() {
    local default_venv="${HOME}/.virtualenvs/default"
    if [[ -d ${default_venv} ]]; then
        echo "default virtualenv exists, skipping" && return 0
    fi
    python3 -m venv ${default_venv}
    source ${default_venv}/bin/activate
    python3 -m pip install -U pip ipython click
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    source ${default_venv}/bin/activate
}

install_packages() {
    if [[ $(uname) == "Darwin" ]]; then
        # On MacOS, install and use brew package manager
        if ! which brew &> /dev/null; then
            echo 'Installing `brew` package manager: https://brew.sh/'
            echo 'Requires user password'
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        fi
        brew install \
            bash \
            git \
            python3 \
            tmux \
            vim
    else
        # Currently only working for Debian and Ubuntu based distros
        if grep -qE "Ubuntu|Debian|Raspbian" /etc/issue; then
            echo "Installing required packages"
            sudo -E apt-get update
            sudo -E apt-get install -yq \
                bash-completion \
                curl \
                dnsutils \
                git \
                python3 \
                python3-pip \
                python3-venv \
                tmux \
                vim-nox
        fi
    fi
}

init() {
    install_packages

    # Set vim as default system editor on linux
    [[ $(uname) == "Darwin" ]] && sudo update-alternatives --set editor /usr/bin/vim.nox

    mkdir -p "${HOME}/.ssh"
    curl -L https://github.com/philipforget.keys >> "${HOME}/.ssh/authorized_keys"

    setup_virtualenv
    setup_dotfiles

    echo "Installing vim plugins"
    vim +'PlugInstall --sync' +qall > /dev/null

    echo "setup complete, run 'source ~/.bashrc' to source changes"
}

init "$@"
