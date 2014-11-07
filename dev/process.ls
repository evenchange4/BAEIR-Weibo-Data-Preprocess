require! {
 \readline 
 \sequelize : Sequelize
 \../config.json : $config
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

# Model Schema
Tweets = sequelize.define do 
  \Tweets
  do
    mid: 
      type: Sequelize.STRING
      # primaryKey: true
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
      type: Sequelize.JSON
    created_at:
      type: Sequelize.DATE
    deleted_last_seen:
      type: Sequelize.STRING
    permission_denied:
      type: Sequelize.STRING

# Tweets.sequelize.sync({force: true}).success !->
Tweets.sequelize.sync().success !->

  readline := readline.createInterface do
    input: process.stdin
    output: process.stdout
    terminal: false

  readline.on \line, (line) !->
    [ mid, retweeted_status_mid, uid, retweeted_uid, source, image, text, geo, created_at, deleted_last_seen, permission_denied ] = line.split \,
    geo = geo || {}
    
    setTimeout do
      !->
        Tweets.create { mid, retweeted_status_mid, uid, retweeted_uid, source, image, text, geo, created_at, deleted_last_seen, permission_denied }
        .success !->
          console.log "Created Successful"
        .error (d)!->
          console.log "Created error: #{d}"
      500

  # readline.on \close, !->
  #   console.log('Have a great day!');
  #   process.exit(0)