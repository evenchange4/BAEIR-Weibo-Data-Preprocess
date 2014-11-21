module.exports = function(sequelize, Sequelize){
  return sequelize.define('UsersWeek4', {
    uid: {
      type: Sequelize.STRING,
      primaryKey: true
    },
    retweets_week4: {
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