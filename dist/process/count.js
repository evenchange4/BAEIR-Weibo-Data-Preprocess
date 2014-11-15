var async, $sequelize, $config, TweetsWeek1, RetweetsWeek1;
async = require('async');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
TweetsWeek1 = $sequelize.TweetsWeek1;
RetweetsWeek1 = $sequelize.RetweetsWeek1;
function retweetsWeek1CreateFn(d, callback){
  RetweetsWeek1.create(d.dataValues).success(function(d){
    return callback();
  }).error(function(d){
    return callback(d);
  });
}
$sequelize.sync(['RetweetsWeek1']).then(function(msg){
  TweetsWeek1.findAll({
    where: {
      retweeted_uid: {
        ne: ""
      }
    }
  }).success(function(d){
    async.each(d, retweetsWeek1CreateFn, function(error){
      if (error) {
        console.log(error);
      } else {
        console.log('done!');
      }
    });
  });
});