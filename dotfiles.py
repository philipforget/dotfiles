#!/usr/bin/env python

from optparse import OptionParser
import sys, os, shutil

OUTPUT_DIR = os.path.expanduser("~")
IGNORE =  {
    "filenames": [
        # Ignore this script and readme
        sys.argv[0].split("/")[-1],
        "README.md"
    ],
    "extensions": [
        "swp",
        "git"
    ]
}

def main():
    global options

    parser = OptionParser(usage="usage: %prog [-v]")
    parser.add_option("-o", action="store_true",
            dest="overwrite", default=False,
            help="overwrite existing files and symlinks")
    parser.add_option("-v", action="store_true",
            dest="verbose", default=False,
            help="display verbose output")

    (options, args) = parser.parse_args()
    
    # For every file in this directory
    for file in os.listdir("."):
        # If the file is not explictely ignored by name or extension
        if (file.split(".")[-1] not in IGNORE["extensions"]
            and file not in IGNORE["filenames"]):
            _conditional_print("creating symlink for %s at %s" % (
                file, os.path.join(OUTPUT_DIR, file)))
            # If the file is already there
            if os.path.lexists(os.path.join(OUTPUT_DIR, file)):
                # Leave the encountered symlink
                if not options.overwrite:
                    _conditional_print("- %s already exists, use -o to overwrite" % (os.path.join(OUTPUT_DIR, file)))
                # Delete the current symlink and create a new one
                else:
                    _conditional_print("- %s already exists, overwriting" % (os.path.join(OUTPUT_DIR, file)))
                    try:
                        os.remove(os.path.join(OUTPUT_DIR, file))
                    # Dealing with a folder
                    except OSError:
                        shutil.rmtree(os.path.join(OUTPUT_DIR, file))
                    os.symlink(os.path.abspath(file), os.path.join(OUTPUT_DIR, file))

            # Create the symlink
            else:
                os.symlink(os.path.abspath(file), os.path.join(OUTPUT_DIR, file))


def _conditional_print(string_to_print):
    if options.verbose:
        print(string_to_print)


if __name__ == '__main__':
    main()
