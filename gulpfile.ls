require!{
  \gulp
  \gulp-livescript
  \gulp-notify
  \gulp-util
}

# LiveScript task
gulp.task \livescript !->
  gulp.src \gulpfile.ls
    .pipe gulp-livescript {+bare, -compile}
    .on \error, ( err ) !->
      gulp-util.log "[error] #{err}"
      @end!
      gulp.src('').pipe gulp-notify '✖ Browserify Failed ✖'
    .pipe gulp.dest \.
  gulp.src \./dev/models/*.ls
    .pipe gulp-livescript {+bare, -compile}
    .on \error, ( err ) !->
      gulp-util.log "[error] #{err}"
      @end!
      gulp.src('').pipe gulp-notify '✖ Browserify Failed ✖'
    .pipe gulp.dest \./dist/models
  gulp.src \./dev/process/*.ls
    .pipe gulp-livescript {+bare, -compile}
    .on \error, ( err ) !->
      gulp-util.log "[error] #{err}"
      @end!
      gulp.src('').pipe gulp-notify '✖ Browserify Failed ✖'
    .pipe gulp.dest \./dist/process

# Watch task
gulp.task \watch ->
  gulp.watch \gulpfile.ls, <[ livescript ]>
  gulp.watch \./dev/models/*.ls, <[ livescript ]>
  gulp.watch \./dev/process/*.ls, <[ livescript ]>

gulp.task \default, <[ livescript watch ]>
