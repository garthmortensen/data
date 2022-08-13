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
filename = "keys.txt"

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

def get_tweets(QUERY, LANGUAGE, FROM_DATE, TWEET_LIMIT):
    """Feed user-defined variables to API call, return tweets"""

    searched_tweets = [status for status in tweepy.Cursor(api.search,
                                                          q=QUERY,
                                                          lang=LANGUAGE,
                                                          since=FROM_DATE).items(TWEET_LIMIT)]
    return searched_tweets


def make_df(searched_tweets, query_clean, FROM_DATE):
    """write wanted tweet fields into df"""
    
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
               FROM_DATE,
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
    
    return df

def write_file(df, filepath, query_clean):
    """write df to intelligently named csv file"""
    
    # timestamp the file in case you want to append csvs
    timestamp = datetime.today().strftime('%Y-%m-%d-%H-%M-%S')
    
    # write to disk
    df.to_csv(filepath + "/output/" + timestamp + "_q_" + query_clean + "_laptop.csv",
              index=False)
    
    print("filewrite at:", timestamp)


# =============================================================================
# query settings
# =============================================================================

# https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/guides/standard-operators
#vaccine #pfizer #astrazeneca #moderna #JohnsonandJohnson #wsb #ai
LANGUAGE = 'en'
FROM_DATE = '2021-01-01'
TWEET_LIMIT = 100

#vaccine #pfizer #astrazeneca #moderna #JohnsonandJohnson #wsb #ai
QUERIES = ['"#vaccine"',
           '"#pfizer"',
           '"#moderna"',
           '"#johnsonandjohnson"',
           '"#astrazeneca"',
           '"#sputnikv"',
           '"#coronavac"',
           '"#epivaccorona"']

# forever loop
while True:
    
    # loop through various queries
    for query in QUERIES:    
        # cleaner query presentation
        query_clean = re.sub(r'\W+', '', query)
        
        # request the tweets
        searched_tweets = get_tweets(query, LANGUAGE, FROM_DATE, TWEET_LIMIT)
        
        # construct the tweets into a df
        df = make_df(searched_tweets, query_clean, FROM_DATE)
        
        # write it to disk
        write_file(df, filepath, query_clean)
