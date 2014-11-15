require! {
  \async
  \gulp-util
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}

# Model Schema
TweetsWeek1 = $sequelize.TweetsWeek1

TweetsWeek1.findAndCountAll  {}
.success (d) !->
  console.log "[0] total tweets of week1 #{d.count}"

TweetsWeek1.findAndCountAll  { where: { retweeted_uid: { ne: "" } } }
.success (d) !->
  console.log "[1] know retweeted uid: #{d.count}"

TweetsWeek1.findAndCountAll  { where: { retweeted_status_mid : { ne: "" } } }
.success (d) !->
  console.log "[2] is retweet: #{d.count}"