# Logging methods

For [data lineage](https://en.wikipedia.org/wiki/Data_lineage), you want to track changes to data every step of the way. These scripts are one part of such a process.

There are 2 variations of this script.

## move_log_to_file.py

```py
 _               _           __ _ _          __  
| | ___   __ _  | |_ ___    / _(_) | ___     \ \ 
| |/ _ \ / _` | | __/ _ \  | |_| | |/ _ \_____\ \
| | (_) | (_| | | || (_) | |  _| | |  __/_gm__/ /
|_|\___/ \__, |  \__\___/  |_| |_|_|\___|    /_/ 
         |___/                                   
```

This script provides the barebones to process files in a directory, and then log processed filenames to a txt.

It performs a superficial processing (read first lines),
then moves files from one directory to another
then logs which files have been moved.

## read_log_to_db.py

```py
 _               _              _ _         __  
| | ___   __ _  | |_ ___     __| | |__      \ \ 
| |/ _ \ / _` | | __/ _ \   / _` | '_ \ _____\ \
| | (_) | (_| | | || (_) | | (_| | |_) |_gm__/ /
|_|\___/ \__, |  \__\___/   \__,_|_.__/     /_/ 
         |___/                                  
```


This script provides the barebones to process files in a directory, and then log processed filenames to a db table.

It performs a superficial processing (read first line),
then inserts it into a db table,
then logs which files have been processed.

It uses a ms sql server db, windows authentication (see connection string).

I've never used pyodbc, so i'll try it instead of sqlalchemy.