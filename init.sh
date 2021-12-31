#!/usr/bin/env bash

# Tell bash to fail immediately on any error as well as unset variables
set -e -o pipefail

export DEBIAN_FRONTEND=noninteractive

symlink() {
    # A symlink function that makes sure the target symlink's parent path
    # exists.

    # Expand ~ to $HOME if present
    local source="${1/#\~/$HOME}"
    local target="${2/#\~/$HOME}"

    [[ -e ${target} ]] && echo "'${target}' exists, skipping" && return

    mkdir -p "$(dirname ${target})"
    ln -s "${source}" "${target}"
}

# Se up the dotfiles repository
setup_dotfiles() {
    local readonly workspace="${HOME}/workspace"
    local readonly dotfiles="${workspace}/dotfiles"
    mkdir -p "${workspace}"

    if [[ -d "${dotfiles}" ]]; then
        echo "dotfiles already cloned, skipping"
    else
        {
            git git@github.com:philipforget/dotfiles.git "${dotfiles}"
        } || {
            echo "Unable to clone via ssh, falling back to https"
            git clone https://github.com/philipforget/dotfiles.git "${dotfiles}"
        }
    fi

    # Set up symlinks
    symlink "${dotfiles}/aliases" ~/.aliases
    symlink "${dotfiles}/aliases_linux" ~/.aliases_linux
    symlink "${dotfiles}/aliases_mac" ~/.aliases_mac
    symlink "${dotfiles}/bash_custom" ~/.bash_custom
    symlink "${dotfiles}/bash_linux" ~/.bash_linux
    symlink "${dotfiles}/bash_mac" ~/.bash_mac
    symlink "${dotfiles}/distraction" ~/.distraction
    symlink "${dotfiles}/docker_config.json" ~/.docker/config.json
    symlink "${dotfiles}/gitconfig" ~/.gitconfig
    symlink "${dotfiles}/pylintrc" ~/.pylintrc
    symlink "${dotfiles}/tmux.conf" ~/.tmux.conf
    symlink "${dotfiles}/vim" ~/.vim
    symlink "${dotfiles}/xmodmap" ~/.xmodmap
    symlink "${dotfiles}/sync-authorized-keys" ~/bin/sync-authorized-keys

    # Mac only symlinks
    if [[ $(uname) == "Darwin" ]]; then
        symlink "${dotfiles}/com.knollsoft.Rectangle.plist" "~/Library/Preferences/com.knollsoft.Rectangle.plist"
    fi

    if ! grep -Fxq 'source ~/.bash_custom' "${HOME}/.bashrc"; then
        echo 'source ~/.bash_custom' >> "${HOME}/.bashrc"
    fi
    if ! grep -Fxq 'source ~/.bash_custom' "${HOME}/.profile"; then
        echo 'source ~/.bash_custom' >> "${HOME}/.profile"
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

setup_system() {
    if [[ $(uname) == "Darwin" ]]; then
        # On MacOS, install and use brew package manager
        if ! which brew &> /dev/null; then
            echo 'Installing `brew` package manager: https://brew.sh/'
            echo 'Requires user password'
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        echo "Installing packages with brew"
        brew install \
            bash \
            bash-completion \
            git \
            mosh \
            python3 \
            tmux \
            vim
        brew install --cask rectangle

        # Install a newer bash than ships with MacOS and set it as the default shell
        brew_bash="$(brew --prefix)/bin/bash"
        # Bail early if ${brew_bash} doesn't exist for any reason
        [[ ! -f ${brew_bash} ]] && echo "Unable to set brew-installed bash as shell!" || {
            echo "Adding ${brew_bash} to /etc/shells if not present"
            grep ${brew_bash} /etc/shells &>/dev/null || echo ${brew_bash} | sudo tee -a /etc/shells
            [[ ${SHELL} = ${brew_bash} ]] || chsh -s ${brew_bash} $(whoami | xargs echo -n)
        }

        # Add ssh agent to system keychain on first unlock
        ssh_agent_config="AddKeysToAgent yes"
        grep "${ssh_agent_config}" ~/.ssh/config &>/dev/null || echo "${ssh_agent_config}" >> ~/.ssh/config
    else
        # Currently only working for Debian and Ubuntu based distros
        if grep -qE "Ubuntu|Debian|Raspbian" /etc/issue; then
            echo "Installing required packages"
            # Use sudo -E to inherit our current environment, including
            # DEBIAN_FRONTEND set above
            sudo -E apt-get -qq update
            sudo -E apt-get -qq install -y \
                --no-install-recommends \
                bash-completion \
                curl \
                dnsutils \
                git \
                python3 \
                python3-pip \
                python3-venv \
                tmux \
                vim-nox

            # Set vim as default system editor
            [[ $(uname) == "Linux" ]] && sudo update-alternatives --set editor /usr/bin/vim.nox
        fi
    fi
}

init() {
    local github_username="${1}"

    setup_system

    # If a github username is provided, import its public keys
    if [[ -n ${github_username} ]]; then
        mkdir -p "${HOME}/.ssh"
        curl -L https://github.com/philipforget.keys >> "${HOME}/.ssh/authorized_keys"
    fi

    setup_virtualenv
    setup_dotfiles

    echo "Installing vim plugins"
    vim +'PlugInstall --sync' +qall &> /dev/null

    echo "setup complete, run 'source ~/.bashrc' to source changes"
}

init "$@"
