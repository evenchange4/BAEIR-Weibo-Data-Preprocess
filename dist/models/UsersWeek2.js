module.exports = function(sequelize, Sequelize){
  return sequelize.define('UsersWeek2', {
    uid: {
      type: Sequelize.STRING,
      primaryKey: true
    },
    retweets_week2: {
      type: Sequelize.INTEGER
    },
    province: {
      type: Sequelize.BIGINT
    },
    gender: {
      type: Sequelize.BOOLEAN
    },
    verified: {
      type: Sequelize.BOOLEAN
    }
  });
};