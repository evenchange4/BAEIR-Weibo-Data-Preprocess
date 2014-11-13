## Weibo Datasets Preprocessing

- Dataset: Open Weiboscope Data Access 香港大學 http://147.8.142.179/datazip/

## Run

```
# Tweets
$ node dist/process/tweets.js ../Weiboscope/tweets/week1.csv > logs/1.log

# Users
$ node dist/process/users.js ../Weiboscope/user/userdata.csv > logs/users.log
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
  "dialect": "postgres"  
}
```

## Reference
- https://github.com/Osterjour/line-by-line