#!/usr/bin/env python

import re
import glob
import sys

expr = r'\d{1}.\d+.\d+'
newConfig = []

# real path on gentoo
path = '/boot/loader/entries/'


# testing path
# path = "/home/scribe/workspace/pyFun/resources/"


def create_new_config(new):
    if len(glob.glob(path)) != 0:
        old_file = glob.glob(f'{path}*.conf')[0]
        with open(old_file) as old_config:
            for line in old_config:
                line = line.rstrip("\n\r")
                newConfig.append(re.sub(expr, new, line))
        new_file_path = f'{path}gentoo-{new}.conf'       
        with open(new_file_path, "w") as newFile:
            for line in newConfig:
                newFile.write(f'{line}\n')
        print(f'Successfully created {new_file_path}')
    else:
        print("Could not find old config file!")


if __name__ == "__main__":
    create_new_config(sys.argv[1])
