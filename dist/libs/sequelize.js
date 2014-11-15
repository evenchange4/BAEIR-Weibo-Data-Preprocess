module.exports = function(){
  var Sequelize, $config, sequelize;
  Sequelize = require('sequelize');
  $config = require('../../config.json');
  sequelize = new Sequelize($config.database, $config.username, $config.password, {
    host: $config.host,
    dialect: $config.dialect,
    port: $config.port,
    logging: $config.logging
  });
  return sequelize;
};