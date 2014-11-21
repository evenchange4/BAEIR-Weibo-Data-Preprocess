var async, gulpUtil, $sequelize, $config, TweetsWeek4, RetweetsWeek4;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
TweetsWeek4 = $sequelize.TweetsWeek4;
RetweetsWeek4 = $sequelize.RetweetsWeek4;
function createFn(d, callback){
  RetweetsWeek4.create(d.dataValues).success(function(d){
    console.log(">>> Processing " + d.dataValues.mid + "...");
    callback();
  }).error(function(d){
    callback(d);
  });
}
$sequelize.sync(['RetweetsWeek4']).then(function(msg){
  TweetsWeek4.findAll({
    where: {
      retweeted_uid: {
        ne: ""
      }
    }
  }).success(function(d){
    gulpUtil.log("[Finished] TweetsWeek4.findAll.");
    async.mapLimit(d, $config.limit, createFn, function(error){
      if (error) {
        console.log(error);
      } else {
        gulpUtil.log("[Finished] retweetsWeek4.Create.");
      }
    });
  });
});