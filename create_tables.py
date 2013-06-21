import MySQLdb

conn = MySQLdb.connect(db="worker_info_production", user="valuessurvey", passwd="garyhsieh", host="localhost", port=3306, charset='utf8') # set up your database here
cur = conn.cursor()
cur.execute("create table if not exists history_status (uid bigint(20) primary key, tweets int, tid bigint(20), completed tinyint(1))")
cur.execute("create table if not exists user_tweet (uid bigint(20), sname varchar(255), tid bigint(20), created bigint(20), message text, retweet tinyint(1), mention tinyint(1), hastag tinyint(1), url tinyint(1), jstring text, primary key(uid, tid))")
cur.execute("create table if not exists home_status (uid bigint(20) primary key, tweets int, tid bigint(20), completed tinyint(1))")
cur.execute("create table if not exists home_tweet (uid bigint(20), authoruid bigint(20), authorsname varchar(255), tid bigint(20), created bigint(20), message text, retweet tinyint(1), mention tinyint(1), hastag tinyint(1), url tinyint(1), jstring text, primary key(uid, tid))")