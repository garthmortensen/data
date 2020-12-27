# -*- coding: utf-8 -*-
"""
  __ _ _                                         __  
 / _(_) | ___   _ __ ___   _____   _____ _ __    \ \ 
| |_| | |/ _ \ | '_ ` _ \ / _ \ \ / / _ \ '__|____\ \
|  _| | |  __/ | | | | | | (_) \ V /  __/ | |_____/ /
|_| |_|_|\___| |_| |_| |_|\___/ \_/ \_gm|_|      /_/ 

This script provides the barebones to move files from one directory to another.

It performs a superficial processing (read first lines),
then moves files from one directory to another
then logs which files have been moved, using a ms sql server db.

I've never used pyodbc, so i'll try it instead of sqlalchemy.
"""

# =============================================================================
# imports
# =============================================================================
import os  # for folders
import pyodbc  # ms sql server
import pandas as pd  # for reading db table
from datetime import datetime  # for logging file movement time

# =============================================================================
# declare and set variables
# =============================================================================

# get path of this script's location and data folders
dir_script = os.path.dirname(__file__)
dir_in = dir_script + "\\data\\in\\"
dir_out = dir_script + "\\data\\out\\"

# files in folder
files_in = os.listdir(dir_in)

# db connection for ms sql server windows auth
conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=CYBERFUCHI5\TESTING;'
                      'Database=AdventureWorksLT2017;'
                      'Trusted_Connection=yes;')

# =============================================================================
# check which files were already processed
# =============================================================================

query_select = "select * from loaded_books"
df = pd.read_sql(query_select, conn)
files_already_loaded = df["processed_file"].tolist()

# =============================================================================
# process data
# =============================================================================

for file in files_in:

    # we don't want to double process
    if file not in files_already_loaded:
        print("file: \t\t" + file)

        text_file = open(dir_in + file,
                         "r",
                         encoding="utf8")

        # read first line content
        first_line = text_file.readlines()[0]
        text_file.close()

        # =========================================================================
        # write file contents
        # =========================================================================

        # process time
        time = str(datetime.now(tz=None))
        cursor = conn.cursor()

        query_insert = "insert into loaded_books_content \
                        (processed_file, firstlines) values \
                        ('" + file + "', '" + first_line + "');"
        cursor.execute(query_insert)

        # =========================================================================
        # write into db log
        # =========================================================================

        query_insert = "insert into loaded_books \
                        (processed_time, processed_file) values \
                        ('" + time + "', '" + file + "');"
        cursor.execute(query_insert)

        cursor.commit()  # otherwise changes are lost
        cursor.close()

    else:
        print("\nfile: " + file + "was already processed!")

conn.close()
