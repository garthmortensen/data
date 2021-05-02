# -*- coding: utf-8 -*-
"""
Created on Sat May  1 17:41:06 2021

@author: me

       _------.
      /  ,     \_
    /   /  /{}\ |o\_
   /    \  `--' /-' \
  |      \      \    |
 |              |`-, |
 /              /__/)/
|              |

This script queries twitters API by lang and exports fields to csv
"""

#pip install tweepy
import tweepy  # for twitter api calls
import pandas as pd  # for building df -> csv
from datetime import datetime  # for timestamped files

# read credentials
filepath = "C:/twitter/"
filename = "keys2.txt"

with open(filepath + filename) as f:
    lines = f.readlines()

consumer_key, consumer_key_secret = lines[0].strip(), lines[1].strip()
access_token, access_token_secret = lines[2].strip(), lines[3].strip()

# setup oath
auth = tweepy.OAuthHandler(consumer_key, consumer_key_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, wait_on_rate_limit=True)

# cleanup
del filename, lines, f, consumer_key, consumer_key_secret, access_token, access_token_secret

# %%

query = 'cbd'
tweet_limit = 5

# https://docs.tweepy.org/en/latest/api.html#search-tweets
searched_tweets = [status for status in tweepy.Cursor(api.search, q=query, lang='en').items(tweet_limit)]

# %%

# %%

for searched_tweet in searched_tweets:
    print(searched_tweet)



# %%

# choose what data fields you want
wanted_fields = ['id', 
                 'created_at', 
                 'lang', 
                 'location', 
                 'text', 
                 'followers_count', 
                 'friends_count']

# create row to hold each jsons values
assemble_row = dict.fromkeys(wanted_fields)
# create a df to hold all rows
assemble_df = pd.DataFrame(columns=wanted_fields)

# iterate through tweets
for searched_tweet in searched_tweets:
    
    # empty prev iteration, since the next could have an empty field and values could be recycled
    assemble_row.clear()

    # =============================================================================
    # assign the json value to variables, and write these values to key
    # =============================================================================
    
    # id
    value_id = searched_tweet.id
    assemble_row['id'] = value_id

    # created_at
    created_at_value = searched_tweet.created_at
    assemble_row['created_at'] = created_at_value
    
    # lang
    value_lang = searched_tweet.lang
    assemble_row['lang'] = value_lang

    # author location
    value_location = searched_tweet.author.location
    assemble_row['location'] = value_location

    # text
    value_text = searched_tweet.text
    assemble_row['text'] = value_text

    # author followers_count
    value_followers_count = searched_tweet.author.followers_count
    assemble_row['followers_count'] = value_followers_count

    # author friends_count
    value_friends_count = searched_tweet.author.friends_count
    assemble_row['friends_count'] = value_friends_count

    #write row to df
    assemble_df = assemble_df.append(assemble_row, ignore_index=True)

# %%

# timestamp the file in case you want to append csvs
ct = datetime.today().strftime('%Y-%m-%d-%H-%M')

# write to disk
assemble_df.to_csv(filepath + "/output/" + ct + "_query_" + query + ".csv",
                   encoding="utf-8",
                   index=False)
