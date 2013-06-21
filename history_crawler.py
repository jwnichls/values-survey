import MySQLdb
import json
import logging
import logging.handlers
import time
import calendar
from Queue import *
from twitter import *

try:
    import urllib.request as urllib2
    import http.client as httplib
except ImportError:
    import urllib2
    import httplib

INTERVAL = 60*15/180
WAIT_TIME = 60*5
MAX_TWEETS = 3000

CONSUMER_KEY = "SS8WuAevZyDM3opvECkfow"
CONSUMER_SECRET = "UygswygDsdyoEdl8ujlH5JugiSKyFOq5gFPVotdfKH0" 

conn = MySQLdb.connect(db="worker_info_production", user="valuessurvey", passwd="garyhsieh", host="localhost", port=3306, charset='utf8') # set up your database here
cur = conn.cursor()

def timestamp(utc_text):
    utc = time.strptime(utc_text.replace('+0000','UTC'), '%a %b %d %H:%M:%S %Z %Y')
    return calendar.timegm(utc)

def clean_text(text, entities):
    message = ""
    mention = False
    hashtag = False
    url = False
    idx_starts = [0]
    idx_ends = [len(text)]
    for entity_type in entities:
        for entity in entities[entity_type]:
            if entity_type == "hashtags":
                hashtag = True
                break
            elif entity_type == "media" or entity_type == "urls":
                url = True
            elif entity_type == "user_mentions":
                mention = True
            idx_end, idx_start = entity['indices']
            idx_starts.append(idx_start)
            idx_ends.append(idx_end)
    idx_starts = sorted(idx_starts)
    idx_ends = sorted(idx_ends)
    for idx_start, idx_end in zip(idx_starts, idx_ends):
        message += text[idx_start:idx_end]
        
    return message, mention, hashtag, url

def save_tweets(uid, tweets):
    completed = False
    max_id = None
    total = 0
    for sname, tid, created, message, retweet, mention, hashtag, url, jstring in tweets:
        cur.execute("""insert ignore into user_tweet
                            values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""", 
                            (uid, sname, tid, created, message, retweet, mention, hashtag, url, jstring))
    conn.commit()
    cur.execute("select min(tid), count(tid) from user_tweet where uid = %s", (uid))
    row = cur.fetchone()
    max_id, total = row
    updated = int(time.time())
    if len(tweets) < 190 or total > MAX_TWEETS:
        completed = True
    cur.execute("replace into history_status values (%s, %s, %s, %s)", (uid, total, max_id, completed))
    conn.commit()
    logging.info("Saved tweets for %s. Now have %s tweets for %s" % (uid, total, uid))
    return completed, max_id
        
    
def timeline_portion(twitter, uid, max_id):
    
    kwargs = dict(count=200, include_rts=1, user_id=uid)
    if max_id is not None:
        kwargs['max_id'] = max_id
    tweets = []
    
    tl = twitter.statuses.user_timeline(**kwargs)
    
    for t in tl:
        tid = t['id']
        created = timestamp(t['created_at'])
        sname = t['user']['screen_name']
        if 'retweeted_status' in t:
            retweet = 1
            message, mention, hashtag, url = clean_text(t['retweeted_status']['text'], t['retweeted_status']['entities'])
        else:
            retweet = 0
            message, mention, hashtag, url = clean_text(t['text'], t['entities'])
        jstring = json.dumps(t)
        tweets.append((sname, tid, created, message, retweet, mention, hashtag, url, jstring))
        
    return tweets

def user_timeline(twitter, uid, max_id=None):
    error = 0
    tweets = []
    
    while error < 10:
        try:
            time.sleep(INTERVAL)
            tweets = timeline_portion(twitter, uid, max_id)
        except TwitterError as e:
            if e.e.code == 401:
                logging.warning("Fail: %i Unauthorized (tweets of that user are protected)" % e.e.code)
                save_tweets(uid, [])
                break
            elif e.e.code == 404:
                logging.info("Fail: %i This profile does not exist" % e.e.code)
                save_tweets(uid, [])
                break
            elif e.e.code == 429:
                logging.warning("Fail: %i API rate limit exceeded" % e.e.code)
                error += 1
                time.sleep(WAIT_TIME)
                continue
            elif e.e.code == 502:
                logging.info("Fail: %i Service currently unavailable, retrying..." % e.e.code)
                error += 1
                continue
            else:
                logging.warning("Fail: %s\nRetrying..." % str(e)[:500])
                error += 1
                continue
        except urllib2.URLError as e:
            logging.info("Fail: urllib2.URLError %s - Retrying..." % str(e))
            error += 1
            continue
        except httplib.error as e:
            logging.info("Fail: httplib.error %s - Retrying..." % str(e))
            error += 1
            continue
        except KeyError as e:
            logging.info("Fail: KeyError %s - Retrying..." % str(e))
            error += 1
            continue
        completed, max_id = save_tweets(uid, tweets)
        if completed:
            break

def crawl_history(log_file):
    logging.basicConfig(level=logging.INFO)
    handler = logging.handlers.RotatingFileHandler(log_file, maxBytes=3000000, backupCount=10)
    handler.setFormatter(logging.Formatter('%(asctime)s %(name)-4s %(levelname)-8s %(message)s', '%m-%d %H:%M'))              
    logger = logging.getLogger('')
    logger.addHandler(handler)
    
    q = Queue(-1)
    
    while True:
        conn.commit()
        cur.execute("select u.uid, u.token, u.secret, hs.tid from users u left join history_status hs on u.uid = hs.uid where (hs.completed is null or hs.completed = 0) order by u.created_at asc limit 100")
        for row in cur.fetchall():
            q.put(row)
        if q.empty():
            time.sleep(INTERVAL)
            continue
        while not q.empty():
            uid, token, secret, tid = q.get()
            t = Twitter(auth=OAuth(token, secret, CONSUMER_KEY, CONSUMER_SECRET))
            user_timeline(t, uid, tid)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(
            description='Crawl tweet history for people')
    parser.add_argument('log_file', help='path to the log file')
    
    args = parser.parse_args()
    crawl_history(args.log_file)