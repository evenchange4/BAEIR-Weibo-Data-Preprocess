var async, gulpUtil, $sequelize, $config, TweetsWeek3, RetweetsWeek3;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
TweetsWeek3 = $sequelize.TweetsWeek3;
RetweetsWeek3 = $sequelize.RetweetsWeek3;
function createFn(d, callback){
  RetweetsWeek3.create(d.dataValues).success(function(d){
    console.log(">>> Processing " + d.dataValues.mid + "...");
    callback();
  }).error(function(d){
    callback(d);
  });
}
$sequelize.sync(['RetweetsWeek3']).then(function(msg){
  TweetsWeek3.findAll({
    where: {
      retweeted_uid: {
        ne: ""
      }
    }
  }).success(function(d){
    gulpUtil.log("[Finished] TweetsWeek3.findAll.");
    async.mapLimit(d, $config.limit, createFn, function(error){
      if (error) {
        console.log(error);
      } else {
        gulpUtil.log("[Finished] retweetsWeek3.Create.");
      }
    });
  });
});