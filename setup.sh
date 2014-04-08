#!/bin/bash

echo "Initializing and updating all submodules"
git submodule init && git submodule update

echo "Installing symlinks"
FILES=( 'gitconfig' 'bash_secret' \
'aliases' 'aliases_linux' 'aliases_mac' \
'bash_custom' 'bash_linux' 'bash_mac' \
'gitconfig' 'hgrc' 'mpd' 'tmux.conf' 'vim' 'vimrc' )

for file in "${FILES[@]}"; do
    echo "Creating symlink for $file"
    if [ -e ~/".$file" ]; then
        echo "~/.$file exists already"
    else
        ln -s ~/dotfiles/$file ~/".$file"
    fi
    echo
done

echo "Done"
