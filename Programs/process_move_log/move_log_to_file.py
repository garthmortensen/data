# -*- coding: utf-8 -*-
"""
 _               _           __ _ _          __  
| | ___   __ _  | |_ ___    / _(_) | ___     \ \ 
| |/ _ \ / _` | | __/ _ \  | |_| | |/ _ \_____\ \
| | (_) | (_| | | || (_) | |  _| | |  __/_gm__/ /
|_|\___/ \__, |  \__\___/  |_| |_|_|\___|    /_/ 
         |___/                                   

This script provides the barebones to process files in a directory,
and then log processed filenames to a txt.

It performs a superficial processing (read first lines),
then moves files from one directory to another
then logs which files have been moved.
"""

# =============================================================================
# imports
# =============================================================================
import os  # for folders
import shutil  # for moving files
from datetime import datetime  # for logging file movement time

# =============================================================================
# declare and set variables
# =============================================================================

# get path of this script's location and data folders
dir_script = os.path.dirname(__file__)
dir_in = dir_script + "\\data\\in\\"
dir_out = dir_script + "\\data\\out\\"

# find what files are being housed
files_in = os.listdir(dir_in)

files_processed = []
first_lines_all = []

# =============================================================================
# process data
# =============================================================================

for file in files_in:
    print("file: \t\t" + file)

    text_file = open(dir_in + file,
                     "r",
                     encoding="utf8")

    # read and display first line content
    first_lines = text_file.readlines()[0:10]
    print("content: \t" + first_lines[0])

    # let's just grab the first line of text
    first_lines_all.append(first_lines)
    files_processed.append(file)
    text_file.close()

    # move file
    shutil.move(dir_in + file, dir_out + file)

    # =========================================================================
    # log movement for data lineage
    # =========================================================================

    print("moved: " + file)
    with open(dir_script + "/log_files_processed.txt", 'a') as f:
        f.write(str(datetime.now(tz=None)) + "\t" + str(file))
        f.write("\n")
