# -*- coding: utf-8 -*-
"""
Created on Sun May  2 12:46:21 2021

@author: morte

union folder of csvs
"""

import os  # for looping over dir
import pandas as pd


filepath = "C:/twitter/output/"

df_all = pd.DataFrame()

i = 0
for file in os.listdir(filepath):
    
    if file.startswith("2021") and file.endswith(".csv"):
        i += 1
        print("reading file: ", i)
        
        df = pd.read_csv(filepath + file)
        
        df_all = df_all.append(df)
        
# write to disk
df_all.to_csv(filepath + "_all_tweets.csv", index=False, header=True)
