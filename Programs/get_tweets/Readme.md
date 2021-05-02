# tweets_2_csv

```asciiarmor
       _------.         "get me my tweets yo"
      /  ,     \_      /
    /   /  /{}\ |o\_
   /    \  `--' /-' \
  |      \      \    |
 |              |`-, |
 /              /gm/)/
|              |
```

ASCII source: https://www.asciiart.eu/animals/birds-land

This script queries Twitter tweets using the Tweepy API, pulls the fields you want, and outputs to timestamped csv.

## get_tweets.py

Iteration 1

- establish basic functionality

## get_tweets_cleaner.py

Iteration 2

- cleaner code 

## get_tweets_cleaner_def.py

Iteration 3

- break into definitions
- add list of queries to loop through
- forever loop it. When API limit reached, it can just resume

## union_all_csv.py

Union all csv in the folder, given filter conditions. It writes over output filename, so you can run this many times without adding unwanted appending.