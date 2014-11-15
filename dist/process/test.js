var async, gulpUtil, $sequelize, $config, TweetsWeek1;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
TweetsWeek1 = $sequelize.TweetsWeek1;
TweetsWeek1.findAndCountAll({}).success(function(d){
  console.log("[0] total tweets of week1 " + d.count);
});
TweetsWeek1.findAndCountAll({
  where: {
    retweeted_uid: {
      ne: ""
    }
  }
}).success(function(d){
  console.log("[1] know retweeted uid: " + d.count);
});
TweetsWeek1.findAndCountAll({
  where: {
    retweeted_status_mid: {
      ne: ""
    }
  }
}).success(function(d){
  console.log("[2] is retweet: " + d.count);
});