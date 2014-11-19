var async, gulpUtil, $sequelize, $config, UsersWeek1, UsersWeek2, UsersWeek1_2;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
UsersWeek1 = $sequelize.UsersWeek2;
UsersWeek2 = $sequelize.UsersWeek2;
UsersWeek1_2 = $sequelize.UsersWeek1_2;
function week1CreateFn(d, callback){
  var uid, retweets_week1;
  uid = d.dataValues.uid;
  retweets_week1 = d.dataValues.retweets_week1;
  UsersWeek1_2.create({
    uid: uid,
    retweets_week1: retweets_week1
  }).success(function(d){
    callback();
  }).error(function(d){
    callback(d);
  });
}
function week2CreateFn(d, callback){
  var uid, retweets_week2;
  uid = d.dataValues.uid;
  retweets_week2 = d.dataValues.retweets_week2;
  UsersWeek1_2.find({
    where: {
      uid: uid
    }
  }).error(function(d){
    return callback(d);
  }).success(function(d){
    if (d === 1) {
      return UsersWeek1_2.update({
        retweets_week2: retweets_week2
      }, {
        uid: uid
      }).success(function(d){
        callback();
      }).error(function(d){
        callback(d);
      });
    } else {
      return UsersWeek1_2.create({
        uid: uid,
        retweets_week2: retweets_week2
      }).success(function(d){
        callback();
      }).error(function(d){
        callback(d);
      });
    }
  });
}
$sequelize.sync(['UsersWeek1_2']).then(function(msg){
  UsersWeek1.findAll({
    attributes: ['uid', 'retweets_week1']
  }).success(function(d){
    gulpUtil.log("[Finished] UsersWeek1.findAll.");
    async.eachLimit(d, $config.limit, week1CreateFn, function(error){
      if (error) {
        console.log(error);
      } else {
        gulpUtil.log("[Finished] week1CreateFn");
        UsersWeek2.findAll({
          attributes: ['uid', 'retweets_week2']
        }).success(function(d){
          gulpUtil.log("[Finished] UsersWeek2.findAll.");
          async.eachLimit(d, $config.limit, week2CreateFn, function(error){
            if (error) {
              console.log(error);
            } else {
              gulpUtil.log("[Finished] week2CreateFn");
            }
          });
        });
      }
    });
  });
});