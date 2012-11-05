# Dotfiles
A (growing) collection of my config files.

## Installation
```bash
# Clone the repo
cd ~ && git clone https://github.com/philipforget/dotfiles.git

# Install all the symlinks, run ./dotfiles.py --help for assistance
cd dotfiles && ./dotfiles.py
```

## dotfiles.py usage

Passing the -v flag will give you verbose output. The -o flag will delete existing files and symlinks in order to create new ones to the files inside the dotfiles folder.

## Options for dotfiles.py:

	Usage: dotfiles.py [-v]

	Options:
	-h, --help  show this help message and exit
	-o          overwrite existing files and symlinks
	-v          display verbose output
