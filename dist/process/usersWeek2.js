var async, gulpUtil, $sequelize, $config, RetweetsWeek2, UsersWeek2, users;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
RetweetsWeek2 = $sequelize.RetweetsWeek2;
UsersWeek2 = $sequelize.UsersWeek2;
users = {};
function eachSeriesFn(d, callback){
  var uid;
  uid = d.dataValues.uid;
  UsersWeek2.find({
    where: {
      uid: uid
    },
    attributes: ['retweets_week2']
  }).success(function(d){
    var retweets_week2;
    if (d) {
      retweets_week2 = d.dataValues.retweets_week2 + 1;
      UsersWeek2.update({
        retweets_week2: retweets_week2
      }, {
        where: {
          uid: uid
        }
      }).success(function(d){
        callback();
      }).error(function(d){
        callback("[Error] UsersWeek2.update error " + d);
      });
    } else {
      UsersWeek2.create({
        uid: uid,
        retweets_week2: 1
      }).success(function(d){
        callback();
      }).error(function(d){
        callback(d);
      });
    }
  }).error(function(d){
    callback("[Error] UsersWeek2.find error " + d);
  });
}
$sequelize.sync(['UsersWeek2']).then(function(msg){
  RetweetsWeek2.findAll({
    attributes: ['uid']
  }).success(function(d){
    async.eachSeries(d, eachSeriesFn, function(error){
      if (error) {
        console.log(error);
      } else {
        gulpUtil.log("[Finished] eachSeries.");
      }
    });
  });
});