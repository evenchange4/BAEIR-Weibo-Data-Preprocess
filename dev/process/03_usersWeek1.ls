# DESC: Count User retweets' number

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
  UsersWeek1.find { where: { uid }, attributes: <[ retweets_week1 ]> }
  .success (d) !->
    if d
      retweets_week1 = d.dataValues.retweets_week1 + 1
      UsersWeek1.update { retweets_week1 }, where: { uid }
      .success (d) !->
        callback!
      .error (d) !->
        callback "[Error] UsersWeek1.update error #{d}"
    else
      UsersWeek1.create { uid, retweets_week1: 1 }
      .success (d) !->
        callback!
      .error (d) !->
        callback d
  .error (d) !->
    callback "[Error] UsersWeek1.find error #{d}"

$sequelize.sync <[ UsersWeek1 ]> .then (msg)!->
  RetweetsWeek1.findAll { attributes: <[ uid ]> }
  .success (d) !->
    async.eachSeries d, eachSeriesFn, (error) !->
      if error 
        console.log error
      else
        gulp-util.log "[Finished] eachSeries."