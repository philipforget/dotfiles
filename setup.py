#!/usr/bin/env python
# -*- coding: utf-8 -*-
import argparse
import os


symlink_mapping = (
    ('aliases', '~/.aliases'),
    ('aliases_linux', '~/.aliases_linux'),
    ('aliases_mac', '~/.aliases_mac'),
    ('bash_custom', '~/.bash_custom'),
    ('bash_linux', '~/.bash_linux'),
    ('bash_mac', '~/.bash_mac'),
    ('gitconfig', '~/.gitconfig'),
    ('hgrc', '~/.hgrc'),
    ('pylintrc', '~/.pylintrc'),
    ('tmux.conf', '~/.tmux.conf'),
    ('vim', '~/.vim'),
    ('vim/init.vim', '~/.vimrc'),
    ('vim', '~/.config/nvim'),
)

def install_symlinks(force=False):
    print("Installing symlinks")
    for path, symlink in symlink_mapping:
        print("{}:".format(symlink))
        file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), path))
        symlink_path = os.path.expanduser(symlink)
        if os.path.islink(symlink_path) and force:
            print("\tremoving existing symlink")
            os.remove(symlink_path)
        elif os.path.isfile(symlink_path) or os.path.islink(symlink_path):
            print("\tfile exists at path")
            continue
        print("\tcreating symlink")
        os.symlink(file_path, symlink_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Set up your symlinks!")
    parser.add_argument('-f', '--force', default=False, dest='force', action='store_true',
        help="if a symlink already exists, overwrite it")
    args = parser.parse_args()
    install_symlinks(force=args.force)
