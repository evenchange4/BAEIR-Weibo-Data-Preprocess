var async, gulpUtil, $sequelize, $config, RetweetsWeek4, UsersWeek4, users;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
RetweetsWeek4 = $sequelize.RetweetsWeek4;
UsersWeek4 = $sequelize.UsersWeek4;
users = {};
function eachSeriesFn(d, callback){
  var uid;
  uid = d.dataValues.uid;
  UsersWeek4.find({
    where: {
      uid: uid
    },
    attributes: ['retweets_week4']
  }).success(function(d){
    var retweets_week4;
    if (d) {
      retweets_week4 = d.dataValues.retweets_week4 + 1;
      UsersWeek4.update({
        retweets_week4: retweets_week4
      }, {
        where: {
          uid: uid
        }
      }).success(function(d){
        callback();
      }).error(function(d){
        callback("[Error] UsersWeek4.update error " + d);
      });
    } else {
      UsersWeek4.create({
        uid: uid,
        retweets_week4: 1
      }).success(function(d){
        callback();
      }).error(function(d){
        callback(d);
      });
    }
  }).error(function(d){
    callback("[Error] UsersWeek4.find error " + d);
  });
}
$sequelize.sync(['UsersWeek4']).then(function(msg){
  RetweetsWeek4.findAll({
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