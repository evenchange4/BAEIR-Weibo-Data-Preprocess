module.exports = (sequelize, Sequelize) ->
  sequelize.define \Users, do
    uid: 
      type: Sequelize.STRING
      primaryKey: true
    province:
      type: Sequelize.BIGINT
    gender:
      type: Sequelize.BOOLEAN
    verified:
      type: Sequelize.BOOLEAN