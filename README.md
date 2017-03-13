## Weibo Datasets Preprocessing

[![Greenkeeper badge](https://badges.greenkeeper.io/evenchange4/BAEIR-Weibo-Data-Preprocess.svg)](https://greenkeeper.io/)

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

- 1. 總比數：

```
SELECT COUNT(*) AS "COUNT" FROM "TweetsWeek2s" AS "TweetsWeek" WHERE "TweetsWeek"."mid" != '';
```

- 2. 不重複人數（unique User ID）

```
SELECT COUNT(DISTINCT uid) AS "COUNT" FROM "TweetsWeek1s"
```

- 3. 屬於 Retweet

```
SELECT COUNT(*) AS "COUNT" FROM "TweetsWeek1s" AS "TweetsWeek" WHERE "TweetsWeek"."retweeted_status_mid" != '';
```

- 4. RetweetsWeek 筆數


```
SELECT COUNT(*) AS "COUNT" FROM "RetweetsWeek2s" AS "RetweetsWeek" WHERE "RetweetsWeek"."mid" != '';
```

