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
$sequelize.sync(['UsersWeek1']).then(function(msg){
  RetweetsWeek1.findAll({
    attributes: ['uid']
  }).success(function(d){
    async.eachSeries(d, eachSeriesFn, function(error){
      var k, ref$, v;
      if (error) {
        console.log(error);
      } else {
        for (k in ref$ = users) {
          v = ref$[k];
          UsersWeek1.create({
            uid: k,
            retweets_week1: v
          }).success(fn$).error(fn1$);
        }
      }
      function fn$(d){}
      function fn1$(d){
        console.log("[usersWeek1.create error] " + d);
      }
    });
  });
});