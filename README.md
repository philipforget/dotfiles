<div style="text-align:center"><img src ="/static/dotfiles.png" /></div>

A collection of my config files. Tested (to various degrees) on OS X, Arch
Linux, and Ubuntu.

## Installation

I like to keep all my repos in a `~/workspace` directory, so I'll assume the
same for you.

```bash
# The only requirement is git, so make sure that's installed
mkdir -p  ~/workspace && cd ~/workspace
git clone https://github.com/philipforget/dotfiles.git
python dotfiles/setup.py
```

## Vim / NeoVim

I've been trying to use neovim recently when it's available. I'll make my vimrc
as backwards compatible as possible in the meantime but some stuff may not work
with older versions of Vim.
