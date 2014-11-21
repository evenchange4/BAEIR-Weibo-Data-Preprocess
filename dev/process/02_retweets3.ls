# DESC: Move retweets from model "TweetsWeek*" to "RetweetsWeek*"
# node 02_retweets.js

require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
TweetsWeek3 = $sequelize.TweetsWeek3
RetweetsWeek3 = $sequelize.RetweetsWeek3

!function createFn (d, callback)
  RetweetsWeek3.create d.dataValues
  .success (d) !->
    console.log ">>> Processing #{d.dataValues.mid}..."
    callback!
  .error (d) !->
    callback d

$sequelize.sync <[ RetweetsWeek3 ]> .then (msg)!->
  TweetsWeek3.findAll { where: { retweeted_uid: { ne: "" } } }
  .success (d) !->
    gulp-util.log "[Finished] TweetsWeek3.findAll."
    async.mapLimit d, $config.limit, createFn, (error) !->
      if error
        console.log error
      else 
        gulp-util.log "[Finished] retweetsWeek3.Create."