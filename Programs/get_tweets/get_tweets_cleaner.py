# -*- coding: utf-8 -*-
"""
Created on Sat May  1 17:41:06 2021

@author: gmort

       _------.
      /  ,     \_
    /   /  /{}\ |o\_
   /    \  `--' /-' \
  |      \      \    |
 |              |`-, |
 /              /__/)/
|              |

This script queries twitters API by lang and exports fields to csv

API 1.1 rate limits
Endpoint                    = GET search/tweets
Requests/window per user	= 180
Requests/window per app     = 450	
"""

#pip install tweepy
import tweepy  # for twitter api calls
import pandas as pd  # for building df -> csv
import re  # for removing all but alphanumeric from query for filename
from datetime import datetime  # for timestamped files

# =============================================================================
# read credentials
# =============================================================================

filepath = "C:/twitter/"
filename = "keys2.txt"

with open(filepath + filename) as f:
    lines = f.readlines()

consumer_key, consumer_key_secret = lines[0].strip(), lines[1].strip()
access_token, access_token_secret = lines[2].strip(), lines[3].strip()

# =============================================================================
# setup API call
# =============================================================================

auth = tweepy.OAuthHandler(consumer_key, consumer_key_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)

# cleanup
del filename, lines, f, consumer_key, consumer_key_secret, access_token, access_token_secret

# %%

# =============================================================================
# query settings
# =============================================================================

# https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/guides/standard-operators
# exact match needs "" operators
#vaccine #pfizer #astrazeneca #moderna #JohnsonandJohnson #wsb #ai
query = '"#pfizer"'
language = 'en'
from_date = '2021-01-01'
tweet_limit = 500

# cleaner query presentation
query_clean = re.sub(r'\W+', '', query)


# https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/api-reference/get-search-tweets
searched_tweets = [status for status in tweepy.Cursor(api.search,
                                                      q=query,
                                                      lang=language,
                                                      since=from_date).items(tweet_limit)]

# %%

# =============================================================================
# load data into df
# =============================================================================

# choose what data fields you want
wanted_fields = ['search_term',
                'from_date',
                'author_id',
                'author_name',
                'author_created_at',
                'author_verified',       
                'author_location',
                'author_description',
                'author_followers_count',
                'author_friends_count',
                'tweet_entities',
                'tweet_id',
                'tweet_created_at',
                'tweet_lang',
                'tweet_text']

tweets = []
for searched_tweet in searched_tweets:
    row = [query_clean,
           from_date,
           searched_tweet.author.id,
           searched_tweet.author.name,
           searched_tweet.author.created_at,
           searched_tweet.author.verified,        
           searched_tweet.author.location,
           searched_tweet.author.description,
           searched_tweet.author.followers_count,
           searched_tweet.author.friends_count,
           searched_tweet.entities,
           searched_tweet.id,
           searched_tweet.created_at,
           searched_tweet.lang,
           searched_tweet.text]
    
    tweets.append(row)

df = pd.DataFrame(tweets, columns=wanted_fields)

# %%

# timestamp the file in case you want to append csvs
ct = datetime.today().strftime('%Y-%m-%d-%H-%M')

# write to disk
df.to_csv(filepath + "/output/" + ct + "_q_" + query_clean + ".csv",
          index=False)
