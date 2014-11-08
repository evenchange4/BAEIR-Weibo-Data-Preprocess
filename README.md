## Weibo Datasets Preprocessing

- Dataset: Open Weiboscope Data Access 香港大學 http://147.8.142.179/datazip/

## Run

```
$ lsc ./dev/process.ls ../data/sample.csv
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