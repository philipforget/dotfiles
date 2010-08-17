#!/usr/bin/env python

from optparse import OptionParser
import sys, os, shutil

OUTPUT_DIR = os.path.expanduser("~/symlinks")
IGNORE =  {
    "filenames": [
        # Ignore this script
        sys.argv[0].split("/")[-1]
    ],
    "extensions": [
        "swp",
        "git"
    ]
}

def main():
    global options

    parser = OptionParser(usage="usage: %prog [-v]")
    parser.add_option("-v", action="store_true",
            dest="verbose", default=False,
            help="display verbose output")

    (options, args) = parser.parse_args()
    
    for file in os.listdir("."):
        if (file.split(".")[-1] not in IGNORE["extensions"]
            and file not in IGNORE["filenames"]):
            _conditional_print("creating symlink for %s at %s" % (
                file, os.path.join(OUTPUT_DIR, file)))
            # If the file is already there
            if os.path.lexists(os.path.join(OUTPUT_DIR, file)):
                _conditional_print("- %s already exists" % (os.path.join(OUTPUT_DIR, file)))

            else:
                os.symlink(file, os.path.join(OUTPUT_DIR, file))


def _conditional_print(string_to_print):
    if options.verbose:
        print(string_to_print)


if __name__ == '__main__':
    main()
