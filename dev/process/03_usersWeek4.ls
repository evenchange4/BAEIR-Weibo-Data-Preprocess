# DESC: Count User retweets' number

require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
RetweetsWeek4 = $sequelize.RetweetsWeek4
UsersWeek4 = $sequelize.UsersWeek4

users = {}

!function eachSeriesFn (d, callback)
  uid = d.dataValues.uid
  UsersWeek4.find { where: { uid }, attributes: <[ retweets_week4 ]> }
  .success (d) !->
    if d
      retweets_week4 = d.dataValues.retweets_week4 + 1
      UsersWeek4.update { retweets_week4 }, where: { uid }
      .success (d) !->
        callback!
      .error (d) !->
        callback "[Error] UsersWeek4.update error #{d}"
    else
      UsersWeek4.create { uid, retweets_week4: 1 }
      .success (d) !->
        callback!
      .error (d) !->
        callback d
  .error (d) !->
    callback "[Error] UsersWeek4.find error #{d}"

$sequelize.sync <[ UsersWeek4 ]> .then (msg)!->
  RetweetsWeek4.findAll { attributes: <[ uid ]> }
  .success (d) !->
    async.eachSeries d, eachSeriesFn, (error) !->
      if error 
        console.log error
      else
        gulp-util.log "[Finished] eachSeries."