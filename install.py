#!/usr/bin/env python

import os
import shutil

from optparse import OptionParser

DOTFILES_DIR = os.path.dirname(__file__)
OUTPUT_DIR = os.path.expanduser("~")
# A mapping of where to symlink our dotfiles
SYMLINKS = {
    'aliases': '.aliases',
    'aliases_linux': '.aliases_linux',
    'aliases_mac': '.aliases_mac',
    'bash_custom': '.bash_custom',
    'bash_linux': '.bash_linux',
    'bash_mac': '.bash_mac',
    'gitconfig': '.gitconfig',
    'hgrc': '.hgrc',
    'mpd': '.mpd',
    'tmux.conf': '.tmux.conf',
    'vim': '.vim',
    'vimrc': '.vimrc',
}


def install():
    parser = OptionParser(usage="usage: %prog [-v]")
    parser.add_option("-o", action="store_true",
            dest="overwrite", default=False,
            help="overwrite existing files and symlinks")
    parser.add_option("-v", action="store_true",
            dest="verbose", default=True,
            help="display verbose output")

    (options, args) = parser.parse_args()

    def cprint(string_to_print):
        if options.verbose:
            print(string_to_print)
    
    os.chdir(DOTFILES_DIR)

    for filename, symlink_location in SYMLINKS.items():
        output = os.path.join(OUTPUT_DIR, symlink_location)

        # If the file is already there
        if os.path.lexists(output):
            # Leave the encountered symlink
            if not options.overwrite:
                cprint("- %s already exists, use -o to overwrite" % (
                    output))
                continue

            # Delete the current symlink and create a new one
            else:
                cprint("- %s already exists, overwriting" % (
                    output))
                try:
                    os.remove(output)
                except OSError:
                    # Dealing with a folder
                    shutil.rmtree(output)

        cprint("creating symlink for %s at %s" % (filename, output))
        # Create the symlink
        os.symlink(os.path.abspath(os.path.join('.', filename)), output)


if __name__ == '__main__':
    install()
