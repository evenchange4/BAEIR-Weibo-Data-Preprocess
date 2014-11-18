var async, gulpUtil, $sequelize, $config, RetweetsWeek1, UsersWeek1, users;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
RetweetsWeek1 = $sequelize.RetweetsWeek1;
UsersWeek1 = $sequelize.UsersWeek1;
users = {};
function eachSeriesFn(d, callback){
  var uid;
  uid = d.dataValues.uid;
  UsersWeek1.find({
    where: {
      uid: uid
    },
    attributes: ['retweets_week1']
  }).success(function(d){
    var retweets_week1;
    if (d) {
      retweets_week1 = d.dataValues.retweets_week1 + 1;
      UsersWeek1.update({
        retweets_week1: retweets_week1
      }, {
        where: {
          uid: uid
        }
      }).success(function(d){
        callback();
      }).error(function(d){
        callback("[Error] UsersWeek1.update error " + d);
      });
    } else {
      UsersWeek1.create({
        uid: uid,
        retweets_week1: 1
      }).success(function(d){
        callback();
      }).error(function(d){
        callback(d);
      });
    }
  }).error(function(d){
    callback("[Error] UsersWeek1.find error " + d);
  });
}
$sequelize.sync(['UsersWeek1']).then(function(msg){
  RetweetsWeek1.findAll({
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