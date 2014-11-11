require! {
 \readline 
 \fs
 \line-by-line
 \moment
 \sequelize : Sequelize
 \../../config.json : $config
}
# filename input
filename = process.argv[2]
# filename.split(\/).pop!split(\.csv)[0]
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

# Model Schema
Users = sequelize.import(__dirname + "/../models/Users")

sequelize.sync({force: $config.force}).success !->
  lr = new line-by-line(filename)
  lr.on \line, (line) !->
    [ uid, province, gender, verified ] = line.split \,
    gender = gender == \m || false
    
    Users.create { uid, province, gender, verified }
    .success !->
      # console.log "Created Successful"
    .error (d)!->
      console.error "[#{moment!format("YYYY-MM-DD HH:mm:ss.SSS")}] [DB Error] Created error: #{d}"

  lr.on \error, (error)!->
    console.error "[#{moment!format("YYYY-MM-DD HH:mm:ss.SSS")}] [LR Error] #{error}"
  lr.on \end, !->
    console.log "[#{moment!format("YYYY-MM-DD HH:mm:ss.SSS")}] Finished #{filename}."
