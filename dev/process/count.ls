require! {
 \../libs/sequelize : $sequelize
 \../../config.json : $config
}

# Database setting
$sequelize = $sequelize!

# Model Schema
TweetsWeek1 = $sequelize.import(__dirname + "/../models/TweetsWeek1")

TweetsWeek1.sync({force: $config.force}).success !->
  TweetsWeek1.findAndCountAll { where: { retweeted_uid: { ne: "" } } }
  .success (d) !->
    console.log d