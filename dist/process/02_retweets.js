var async, gulpUtil, $sequelize, $config, TweetsWeek2, RetweetsWeek2;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
TweetsWeek2 = $sequelize.TweetsWeek2;
RetweetsWeek2 = $sequelize.RetweetsWeek2;
function createFn(d, callback){
  RetweetsWeek2.create(d.dataValues).success(function(d){
    console.log(">>> Processing " + d.dataValues.mid + "...");
    callback();
  }).error(function(d){
    callback(d);
  });
}
$sequelize.sync(['RetweetsWeek2']).then(function(msg){
  TweetsWeek2.findAll({
    where: {
      retweeted_uid: {
        ne: ""
      }
    }
  }).success(function(d){
    gulpUtil.log("[Finished] TweetsWeek2.findAll.");
    async.mapLimit(d, $config.limit, createFn, function(error){
      if (error) {
        console.log(error);
      } else {
        gulpUtil.log("[Finished] retweetsWeek2.Create.");
      }
    });
  });
});