require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
RetweetsWeek1 = $sequelize.RetweetsWeek1
UsersWeek1 = $sequelize.UsersWeek1

users = {}

!function eachSeriesFn (d, callback)
  uid = d.dataValues.uid
  if users.hasOwnProperty uid
    users[uid] += 1
  else
    users[uid] = 1
  callback!

!function eachLimitFn (d, callback)
  UsersWeek1.create { uid: d, retweets_week1: users[d] }
  .success (d) !->
    callback!
  .error (d) !->
    callback d

$sequelize.sync <[ UsersWeek1 ]> .then (msg)!->
  RetweetsWeek1.findAll { attributes: <[ uid ]> }
  .success (d) !->
    async.eachSeries d, eachSeriesFn, (error) !->
      if error 
        console.log error
      else
        async.eachLimit Object.keys(users), $config.limit, eachLimitFn, (error) !->
          if error
            console.log error
          else 
            gulp-util.log "[Finished] UsersWeek1.Create."