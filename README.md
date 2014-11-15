## Weibo Datasets Preprocessing

- Dataset: Open Weiboscope Data Access 香港大學 http://147.8.142.179/datazip/

## Run

```
# Tweets
$ node dist/process/tweets.js ../Weiboscope/tweets/week1.csv > logs/1.log

# Users
$ node dist/process/users.js ../Weiboscope/user/userdata.csv > logs/users.log

# Retweet Fetch
$ node dist/process/count.js
```

## Configuration

Edit `./config.json`

```
{
  "database":"database",
  "username":"username",
  "password":"password",
  "host":"localhost",
  "port": 5432,
  "dialect": "postgres",
  "logging": false,
  "force": false
}
```

## Reference
- https://github.com/Osterjour/line-by-line

## SQL

```
SELECT COUNT(*) AS "COUNT" FROM "TweetsWeek1s" AS "TweetsWeek1" WHERE "TweetsWeek1"."mid" != '';
```

```
SELECT COUNT(*) AS "COUNT" FROM "TweetsWeek1s" AS "TweetsWeek1" WHERE "TweetsWeek1"."retweeted_status_mid" != '';
```

```
SELECT COUNT(DISTINCT uid) AS "COUNT" FROM "TweetsWeek1s"
```


```
SELECT COUNT(*) AS "COUNT" FROM "TweetsWeek1s" AS "TweetsWeek1" WHERE "TweetsWeek1"."retweeted_uid" != '';
```

