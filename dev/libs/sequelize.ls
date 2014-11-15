module.exports = ->
  require! {
   \sequelize : Sequelize
   \../../config.json : $config
  }

  # Database setting
  sequelize = new Sequelize do
    $config.database
    $config.username
    $config.password
    do 
      host: $config.host
      dialect: $config.dialect
      port: $config.port
      logging: $config.logging

  sequelize