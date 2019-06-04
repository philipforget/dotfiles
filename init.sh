#!/usr/bin/env bash


setup_dotfiles() {
    mkdir -p ~/workspace
    pushd ~/workspace
    if [[ -d dotfiles ]]; then
        echo "dotfiles already cloned, skipping"
        return 0
    else
        git clone https://github.com/philipforget/dotfiles.git
        cd dotfiles
        python3 setup.py

        if ! grep -Fxq 'source ~/.bash_custom' ~/.bashrc; then
            echo 'source ~/.bash_custom' >> ~/.bashrc
            source ~/.bash_custom
        fi
    fi
    popd
}

setup_virtualenv() {
    if [[ -d ~/.default_virtulenv ]]; then
        echo "default virtualenv exists, skipping" && return 0
    fi
    python3 -m venv ~/.default_virtulenv
    source ~/.default_virtulenv/bin/activate
    python3 -m pip install -U pip ipython click
}

init() {
    if grep -Fq Ubuntu /etc/issue; then
        echo "Installing required packages"
        sudo apt-get update
        sudo apt-get install -yq vim git tmux python3 python3-pip python3-venv
    fi

    curl -L https://github.com/philipforget.keys >> ~/.ssh/authorized_keys

    setup_virtualenv
    setup_dotfiles
}

init "$@"
