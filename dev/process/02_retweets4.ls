# DESC: Move retweets from model "TweetsWeek*" to "RetweetsWeek*"
# node 02_retweets.js

require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
TweetsWeek4 = $sequelize.TweetsWeek4
RetweetsWeek4 = $sequelize.RetweetsWeek4

!function createFn (d, callback)
  RetweetsWeek4.create d.dataValues
  .success (d) !->
    console.log ">>> Processing #{d.dataValues.mid}..."
    callback!
  .error (d) !->
    callback d

$sequelize.sync <[ RetweetsWeek4 ]> .then (msg)!->
  TweetsWeek4.findAll { where: { retweeted_uid: { ne: "" } } }
  .success (d) !->
    gulp-util.log "[Finished] TweetsWeek4.findAll."
    async.mapLimit d, $config.limit, createFn, (error) !->
      if error
        console.log error
      else 
        gulp-util.log "[Finished] retweetsWeek4.Create."