require! {
  \fs
  \path
  \gulp-util
  \async
  \q : Q
  \sequelize : Sequelize
  \../../config.json : $config
}
# return Object
db = {}

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

# load Models
fs.readdirSync "#{__dirname}/../models"
  .forEach (e) !->
    model = sequelize.import path.join("#{__dirname}/../models", e)
    db[model.name] = model

# associate
Object.keys(db).forEach (modelName) !->
  if "associate" in db[modelName]
    db[modelName].associate(db)

!function mapSyncFn (model, callback)
  db[model].sync({ force: $config.force })
  .success !->
    callback!
  .error !->
    callback "[Error] Model-#{model} sync Fail"

sync = (modelNames) ->
  deferred = Q.defer!
  async.each modelNames, mapSyncFn, (error) !->
    if error
      gulp-util.log error
    else
      deferred.resolve "[SYNC] Models sync Success"
  deferred.promise

db.sequelize = sequelize
db.Sequelize = Sequelize
db.sync = sync

module.exports = db