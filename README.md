# Dotfiles
A (growing) collection of my config files.  Clone the directory to ~/dotfiles (or wherever you want) and run the dotfiles.py found inside. This will create the requisite symlinks into your home folder. You can change the folder into which the symlinks are placed by editing the header of the script.  

## dotfiles.py usage

Passing the -v flag will give you verbose output. The -o flag will delete existing files and symlinks in order to create new ones to the files inside the dotfiles folder.

## Options for dotfiles.py:

	Usage: dotfiles.py [-v]

	Options:
	-h, --help  show this help message and exit
	-o          overwrite existing files and symlinks
	-v          display verbose output
