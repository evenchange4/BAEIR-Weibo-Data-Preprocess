# DESC: Count User retweets' number

require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
UsersWeek1 = $sequelize.UsersWeek1
UsersWeek2 = $sequelize.UsersWeek2
UsersWeek1_2 = $sequelize.UsersWeek1_2

!function week1CreateFn (d, callback)
  uid = d.dataValues.uid
  retweets_week1 = d.dataValues.retweets_week1

  UsersWeek1_2.create { uid, retweets_week1 }
  .success (d) !-> callback!
  .error (d) !-> callback d

!function week2CreateFn (d, callback)
  uid = d.dataValues.uid
  retweets_week2 = d.dataValues.retweets_week2

  UsersWeek1_2.find { where:{ uid } }
  .error (d) -> callback d
  .success (d) ->
    if d
      UsersWeek1_2.update { retweets_week2 }, where: { uid }
      .success (d) !-> callback!
      .error (d) !-> callback d
    else
      UsersWeek1_2.create { uid, retweets_week2 }
      .success (d) !-> callback!
      .error (d) !-> callback d

$sequelize.sync <[ UsersWeek1_2 ]> .then (msg)!->
  UsersWeek1.findAll { attributes: <[ uid retweets_week1 ]> }
  .success (d) !->
    gulp-util.log "[Finished] UsersWeek1.findAll."
    async.eachLimit d, $config.limit, week1CreateFn, (error) !->
      if error
        console.log error
      else 
        gulp-util.log "[Finished] week1CreateFn"

        UsersWeek2.findAll { attributes: <[ uid retweets_week2 ]> }
        .success (d) !->
          gulp-util.log "[Finished] UsersWeek2.findAll."
          async.eachLimit d, $config.limit, week2CreateFn, (error) !->
            if error
              console.log error
            else 
              gulp-util.log "[Finished] week2CreateFn"

