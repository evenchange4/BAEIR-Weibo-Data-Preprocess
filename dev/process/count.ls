require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
TweetsWeek1 = $sequelize.TweetsWeek1
RetweetsWeek1 = $sequelize.RetweetsWeek1

!function retweetsWeek1CreateFn (d, callback)
  RetweetsWeek1.create d.dataValues
  .success (d) !->
    console.log ">>> Processing #{d.dataValues.mid}..."
    callback!
  .error (d) !->
    callback d

$sequelize.sync <[ RetweetsWeek1 ]> .then (msg)!->
  TweetsWeek1.findAll { where: { retweeted_uid: { ne: "" } } }
  .success (d) !->
    gulp-util.log "[Finished] TweetsWeek1.findAll."
    async.mapLimit d, $config.limit, retweetsWeek1CreateFn, (error) !->
      if error
        console.log error
      else 
        gulp-util.log "[Finished] retweetsWeek1.Create."