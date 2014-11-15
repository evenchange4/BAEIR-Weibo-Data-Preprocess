require! {
  \async
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
TweetsWeek1 = $sequelize.TweetsWeek1
RetweetsWeek1 = $sequelize.RetweetsWeek1

!function retweetsWeek1CreateFn (d, callback)
  RetweetsWeek1.create d.dataValues
  .success (d)->
    callback!
  .error (d)->
    callback d

$sequelize.sync <[ RetweetsWeek1 ]> .then (msg)!->
  TweetsWeek1.findAll { where: { retweeted_uid: { ne: "" } } }
  .success (d) !->
    async.each d, retweetsWeek1CreateFn, (error) !->
      if error
        console.log error
      else 
        console.log \done!