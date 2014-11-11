module.exports = function(sequelize, Sequelize){
  return sequelize.define('Users', {
    uid: {
      type: Sequelize.STRING,
      primaryKey: true
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