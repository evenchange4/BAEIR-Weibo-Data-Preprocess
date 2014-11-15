module.exports = (sequelize, Sequelize) ->
  sequelize.define \UsersWeek1, do
    uid: 
      type: Sequelize.STRING
      primaryKey: true
    retweets_week1:
      type: Sequelize.INTEGER
    province:
      type: Sequelize.BIGINT
    gender:
      type: Sequelize.BOOLEAN
    verified:
      type: Sequelize.BOOLEAN