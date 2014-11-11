module.exports = (sequelize, Sequelize) ->
  sequelize.define \Tweets, do
    mid: 
      type: Sequelize.STRING
      primaryKey: true
    retweeted_status_mid:
      type: Sequelize.STRING
    uid: 
      type: Sequelize.STRING
    retweeted_uid:
      type: Sequelize.STRING
    source:
      type: Sequelize.STRING
    image:
      type: Sequelize.BOOLEAN
    text:
      type: Sequelize.TEXT
    geo:
      type: Sequelize.TEXT
    created_at:
      type: Sequelize.DATE
    deleted_last_seen:
      type: Sequelize.TEXT
    permission_denied:
      type: Sequelize.TEXT