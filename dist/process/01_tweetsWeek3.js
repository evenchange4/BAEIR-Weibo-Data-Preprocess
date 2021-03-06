var readline, fs, lineByLine, moment, $sequelize, $config, filename, TweetsWeek3;
readline = require('readline');
fs = require('fs');
lineByLine = require('line-by-line');
moment = require('moment');
$sequelize = require('../libs/sequelize');
$config = require('../../config.json');
filename = process.argv[2];
TweetsWeek3 = $sequelize.TweetsWeek3;
$sequelize.sync(['TweetsWeek3']).then(function(msg){
  var lr;
  lr = new lineByLine(filename);
  lr.on('line', function(line){
    var ref$, mid, retweeted_status_mid, uid, retweeted_uid, source, image, text, geo, created_at, deleted_last_seen, permission_denied;
    ref$ = line.split(','), mid = ref$[0], retweeted_status_mid = ref$[1], uid = ref$[2], retweeted_uid = ref$[3], source = ref$[4], image = ref$[5], text = ref$[6], geo = ref$[7], created_at = ref$[8], deleted_last_seen = ref$[9], permission_denied = ref$[10];
    created_at = new Date(created_at).getTime() || null;
    deleted_last_seen = new Date(deleted_last_seen).getTime() || null;
    TweetsWeek3.create({
      mid: mid,
      retweeted_status_mid: retweeted_status_mid,
      uid: uid,
      retweeted_uid: retweeted_uid,
      source: source,
      image: image,
      text: text,
      geo: geo,
      created_at: created_at,
      deleted_last_seen: deleted_last_seen,
      permission_denied: permission_denied
    }).success(function(){}).error(function(d){
      console.log("[" + moment().format("YYYY-MM-DD HH:mm:ss.SSS") + "] [DB Error] Created error: " + d);
      console.log(line);
      TweetsWeek3.update({
        duplicated: true
      }, {
        where: {
          mid: mid
        }
      }).error(function(d){
        console.log(d);
      });
    });
  });
  lr.on('error', function(error){
    console.log("[" + moment().format("YYYY-MM-DD HH:mm:ss.SSS") + "] [LR Error] " + error);
  });
  lr.on('end', function(){
    console.log("[" + moment().format("YYYY-MM-DD HH:mm:ss.SSS") + "] Finished " + filename + ".");
  });
});