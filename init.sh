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
        fi
    fi
    popd
}

init() {
    if grep -Fq Ubuntu /etc/issue; then
        echo "Installing required packages"
        sudo apt-get update && apt-get install -yq vim git tmux python3 python3-pip python3-venv
    fi

    curl -L https://github.com/philipforget.keys >> ~/.ssh/authorized_keys

    setup_dotfiles
}

init "$@"
