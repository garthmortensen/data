# -*- coding: utf-8 -*-
"""
Created on Sun May  2 12:46:21 2021

@author: morte

union folder of csvs
"""

import os  # for looping over dir
import pandas as pd


filepath = "C:/gdrive/01_StThomas/11_BigDataEngineering/11_project/data/"
# filepath = "C:/twitter/output/batch3/"


# get total file count for % complete
total_files = 0
for file in os.listdir(filepath):    
    # if file.startswith("2021") and file.endswith(".csv"):
    total_files += 1

# %%

i = 0
df_all = pd.DataFrame()
for file in os.listdir(filepath):
    df = pd.read_csv(filepath + file)
    df_all = df_all.append(df)
    
    i += 1
    print("out of:", total_files, ", processing file:", i)

# write to disk
df_all.to_csv(filepath + "_all_tweets.csv", index=False, header=True)
