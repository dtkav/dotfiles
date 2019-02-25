#!/usr/bin/env python

"""
This script creates a symbolic links for each file or folder within the script
directory that starts with a dot into your home directory. This way you can
manage all of your dofiles from within a signle .git repo.

The .git directory is not linked into your home directory.
"""

from __future__ import print_function

import os
import distutils.util
import errno
import shutil


exclude_list = [".git", ".gitmodules", ".gitignore"]

# python2 compatability
try:
    input = raw_input
except NameError:
    pass

def prompt(str):
    while True:
        print(str + " [y/n]", end=" "),
        choice = input()
        try:
            ret = distutils.util.strtobool(choice)
            break
        except ValueError:
            pass
    return ret

def main():
    dotfiles_dir = os.path.dirname(os.path.realpath(__file__))
    for dotfile in os.listdir(dotfiles_dir):
        if dotfile[0] == "." and dotfile not in exclude_list:
            home = os.path.expanduser("~")
            src = os.path.join(os.path.relpath(dotfiles_dir, home), dotfile)
            dst = os.path.join(home, dotfile)

            if os.path.islink(dst):
                print("skipping %s (already symlink)" % dst)
                continue

            if os.path.exists(dst):
                overwrite = prompt("do you want to overwrite " + dst + "?")
                if not overwrite:
                    continue

            try:
                os.symlink(src, dst)
            except OSError as e:
                if e.errno == errno.EEXIST:
                    if os.path.isdir(dst):
                        try:
                            shutil.rmtree(dst)
                        except OSError:
                            os.unlink(dst)
                    else:
                        os.unlink(dst)
                    os.symlink(src, dst)
            print("symlink %s -> %s" % (dst, src))

if __name__ == "__main__":
    main()   
