# DESC: Count User retweets' number

require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
RetweetsWeek2 = $sequelize.RetweetsWeek2
UsersWeek2 = $sequelize.UsersWeek2

users = {}

!function eachSeriesFn (d, callback)
  uid = d.dataValues.uid
  UsersWeek2.find { where: { uid }, attributes: <[ retweets_week2 ]> }
  .success (d) !->
    if d
      retweets_week2 = d.dataValues.retweets_week2 + 1
      UsersWeek2.update { retweets_week2 }, where: { uid }
      .success (d) !->
        callback!
      .error (d) !->
        callback "[Error] UsersWeek2.update error #{d}"
    else
      UsersWeek2.create { uid, retweets_week2: 1 }
      .success (d) !->
        callback!
      .error (d) !->
        callback d
  .error (d) !->
    callback "[Error] UsersWeek2.find error #{d}"

$sequelize.sync <[ UsersWeek2 ]> .then (msg)!->
  RetweetsWeek2.findAll { attributes: <[ uid ]> }
  .success (d) !->
    async.eachSeries d, eachSeriesFn, (error) !->
      if error 
        console.log error
      else
        gulp-util.log "[Finished] eachSeries."