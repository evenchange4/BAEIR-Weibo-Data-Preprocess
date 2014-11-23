# DESC: Count User retweets' number

require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
RetweetsWeek3 = $sequelize.RetweetsWeek3
UsersWeek3 = $sequelize.UsersWeek3

users = {}

!function eachSeriesFn (d, callback)
  uid = d.dataValues.uid
  UsersWeek3.find { where: { uid }, attributes: <[ retweets_week3 ]> }
  .success (d) !->
    if d
      retweets_week3 = d.dataValues.retweets_week3 + 1
      UsersWeek3.update { retweets_week3 }, where: { uid }
      .success (d) !->
        callback!
      .error (d) !->
        callback "[Error] UsersWeek3.update error #{d}"
    else
      UsersWeek3.create { uid, retweets_week3: 1 }
      .success (d) !->
        callback!
      .error (d) !->
        callback d
  .error (d) !->
    callback "[Error] UsersWeek3.find error #{d}"

$sequelize.sync <[ UsersWeek3 ]> .then (msg)!->
  RetweetsWeek3.findAll { attributes: <[ uid ]> }
  .success (d) !->
    async.eachSeries d, eachSeriesFn, (error) !->
      if error 
        console.log error
      else
        gulp-util.log "[Finished] eachSeries."