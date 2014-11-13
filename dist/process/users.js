var readline, fs, lineByLine, moment, Sequelize, $config, filename, sequelize, Users;
readline = require('readline');
fs = require('fs');
lineByLine = require('line-by-line');
moment = require('moment');
Sequelize = require('sequelize');
$config = require('../../config.json');
filename = process.argv[2];
sequelize = new Sequelize($config.database, $config.username, $config.password, {
  host: $config.host,
  dialect: $config.dialect,
  port: $config.port,
  logging: $config.logging
});
Users = sequelize['import'](__dirname + "/../models/Users");
sequelize.sync({
  force: $config.force
}).success(function(){
  var lr;
  lr = new lineByLine(filename);
  lr.on('line', function(line){
    var ref$, uid, province, gender, verified;
    ref$ = line.split(','), uid = ref$[0], province = ref$[1], gender = ref$[2], verified = ref$[3];
    gender = gender === 'm' || false;
    Users.create({
      uid: uid,
      province: province,
      gender: gender,
      verified: verified
    }).success(function(){}).error(function(d){
      console.log("[" + moment().format("YYYY-MM-DD HH:mm:ss.SSS") + "] [DB Error] Created error: " + d);
      console.log(line);
    });
  });
  lr.on('error', function(error){
    console.log("[" + moment().format("YYYY-MM-DD HH:mm:ss.SSS") + "] [LR Error] " + error);
  });
  lr.on('end', function(){
    console.log("[" + moment().format("YYYY-MM-DD HH:mm:ss.SSS") + "] Finished " + filename + ".");
  });
});