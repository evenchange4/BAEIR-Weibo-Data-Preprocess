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
  if (users.hasOwnProperty(uid)) {
    users[uid] += 1;
  } else {
    users[uid] = 1;
  }
  callback();
}
function eachLimitFn(d, callback){
  UsersWeek1.create({
    uid: d,
    retweets_week1: users[d]
  }).success(function(d){
    callback();
  }).error(function(d){
    callback(d);
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
        async.eachLimit(Object.keys(users), $config.limit, eachLimitFn, function(error){
          if (error) {
            console.log(error);
          } else {
            gulpUtil.log("[Finished] UsersWeek1.Create.");
          }
        });
      }
    });
  });
});