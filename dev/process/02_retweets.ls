# DESC: Move retweets from model "TweetsWeek*" to "RetweetsWeek*"
# node 02_retweets.js

require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
TweetsWeek2 = $sequelize.TweetsWeek2
RetweetsWeek2 = $sequelize.RetweetsWeek2

!function createFn (d, callback)
  RetweetsWeek2.create d.dataValues
  .success (d) !->
    console.log ">>> Processing #{d.dataValues.mid}..."
    callback!
  .error (d) !->
    callback d

$sequelize.sync <[ RetweetsWeek2 ]> .then (msg)!->
  TweetsWeek2.findAll { where: { retweeted_uid: { ne: "" } } }
  .success (d) !->
    gulp-util.log "[Finished] TweetsWeek2.findAll."
    async.mapLimit d, $config.limit, createFn, (error) !->
      if error
        console.log error
      else 
        gulp-util.log "[Finished] retweetsWeek2.Create."