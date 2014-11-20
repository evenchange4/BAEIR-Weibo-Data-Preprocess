require! {
  \readline 
  \fs
  \line-by-line
  \moment
  \../libs/sequelize : $sequelize
  \../../config.json : $config
}
filename = process.argv[2]

# Model Schema
TweetsWeek1 = $sequelize.TweetsWeek1

$sequelize.sync <[ TweetsWeek1 ]> .then (msg)!->
  lr = new line-by-line(filename)
  lr.on \line, (line) !->
    [ mid, retweeted_status_mid, uid, retweeted_uid, source, image, text, geo, created_at, deleted_last_seen, permission_denied ] = line.split \,
    created_at = new Date(created_at).getTime! || null
    deleted_last_seen = new Date(deleted_last_seen).getTime! || null
    TweetsWeek1.create { mid, retweeted_status_mid, uid, retweeted_uid, source, image, text, geo, created_at, deleted_last_seen, permission_denied }
    .success !->
      # console.log "Created Successful"
    .error (d)!->
      console.log "[#{moment!format("YYYY-MM-DD HH:mm:ss.SSS")}] [DB Error] Created error: #{d}"
      console.log line
      TweetsWeek1.update { +duplicated }, where: { mid }
      .error (d)!-> console.log d
  lr.on \error, (error)!->
    console.log "[#{moment!format("YYYY-MM-DD HH:mm:ss.SSS")}] [LR Error] #{error}"
  lr.on \end, !->
    console.log "[#{moment!format("YYYY-MM-DD HH:mm:ss.SSS")}] Finished #{filename}."
