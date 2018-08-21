#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from pathlib import Path

import argparse
import os

IS_MAC = os.uname().sysname == 'Darwin'


general = (
    ('aliases', '~/.aliases'),
    ('aliases_linux', '~/.aliases_linux'),
    ('aliases_mac', '~/.aliases_mac'),
    ('bash_custom', '~/.bash_custom'),
    ('bash_linux', '~/.bash_linux'),
    ('bash_mac', '~/.bash_mac'),
    ('distraction', '~/.distraction'),
    ('gitconfig', '~/.gitconfig'),
    ('hgrc', '~/.hgrc'),
    ('pylintrc', '~/.pylintrc'),
    ('tmux.conf', '~/.tmux.conf'),
    ('vim', '~/.vim'),
    ('vim/init.vim', '~/.vimrc'),
    ('vim', '~/.config/nvim'),
    ('xmodmap', '~/.xmodmap'),
)

mac_only = (
    ('Shortcuts.json', '~/Library/Application Support/Spectacle/Shortcuts.json'),
)


def create_symlinks(symlink_map):
    for filename, location in symlink_map:
        filepath = Path(filename).resolve()
        target = Path(location).expanduser().resolve()

        print("{} -> {}:".format(filepath, target))

        if target.exists() or target.is_symlink():
            print("\tfile exists at path, skipping")
            continue

        target.parent.mkdir(parents=True, exist_ok=True)
        target.symlink_to(filepath)


if __name__ == "__main__":
    create_symlinks(general)
    if IS_MAC:
        create_symlinks(mac_only)
