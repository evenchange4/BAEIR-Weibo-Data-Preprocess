var async, gulpUtil, $sequelize, $config, RetweetsWeek3, UsersWeek3, users;
async = require('async');
gulpUtil = require('gulp-util');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
RetweetsWeek3 = $sequelize.RetweetsWeek3;
UsersWeek3 = $sequelize.UsersWeek3;
users = {};
function eachSeriesFn(d, callback){
  var uid;
  uid = d.dataValues.uid;
  UsersWeek3.find({
    where: {
      uid: uid
    },
    attributes: ['retweets_week3']
  }).success(function(d){
    var retweets_week3;
    if (d) {
      retweets_week3 = d.dataValues.retweets_week3 + 1;
      UsersWeek3.update({
        retweets_week3: retweets_week3
      }, {
        where: {
          uid: uid
        }
      }).success(function(d){
        callback();
      }).error(function(d){
        callback("[Error] UsersWeek3.update error " + d);
      });
    } else {
      UsersWeek3.create({
        uid: uid,
        retweets_week3: 1
      }).success(function(d){
        callback();
      }).error(function(d){
        callback(d);
      });
    }
  }).error(function(d){
    callback("[Error] UsersWeek3.find error " + d);
  });
}
$sequelize.sync(['UsersWeek3']).then(function(msg){
  RetweetsWeek3.findAll({
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