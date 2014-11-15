module.exports = function(sequelize, Sequelize){
  return sequelize.define('RetweetsWeek1', {
    mid: {
      type: Sequelize.STRING,
      primaryKey: true
    },
    retweeted_status_mid: {
      type: Sequelize.STRING
    },
    uid: {
      type: Sequelize.STRING
    },
    retweeted_uid: {
      type: Sequelize.STRING
    },
    source: {
      type: Sequelize.STRING
    },
    image: {
      type: Sequelize.BOOLEAN
    },
    text: {
      type: Sequelize.TEXT
    },
    geo: {
      type: Sequelize.TEXT
    },
    created_at: {
      type: Sequelize.BIGINT,
      allowNull: true
    },
    deleted_last_seen: {
      type: Sequelize.BIGINT,
      allowNull: true
    },
    permission_denied: {
      type: Sequelize.TEXT
    },
    duplicated: {
      type: Sequelize.BOOLEAN,
      defaultValue: false
    }
  });
};