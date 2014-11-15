var $sequelize, $config, TweetsWeek1;
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
$sequelize = $sequelize();
TweetsWeek1 = $sequelize['import'](__dirname + "/../models/TweetsWeek1");
TweetsWeek1.sync({
  force: $config.force
}).success(function(){
  TweetsWeek1.findAndCountAll({
    where: {
      retweeted_uid: {
        ne: ""
      }
    }
  }).success(function(d){
    console.log(d);
  });
});