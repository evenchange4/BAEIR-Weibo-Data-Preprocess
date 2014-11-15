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

$sequelize.sync <[ UsersWeek1 ]> .then (msg)!->
  RetweetsWeek1.findAll { attributes: <[ uid ]> }
  .success (d) !->
    async.eachSeries d, eachSeriesFn, (error) !->
      if error 
        console.log error
      else
        for k,v of users
          UsersWeek1.create { uid: k, retweets_week1: v }
          .success (d) !->
          .error (d) !->
            console.log "[usersWeek1.create error] #{d}"