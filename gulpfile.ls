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
  gulp.src \./dev/**/*.ls
    .pipe gulp-livescript {+bare, -compile}
    .on \error, ( err ) !->
      gulp-util.log "[error] #{err}"
      @end!
      gulp.src('').pipe gulp-notify '✖ Browserify Failed ✖'
    .pipe gulp.dest \./dist/

# Watch task
gulp.task \watch ->
  gulp.watch \gulpfile.ls, <[ livescript ]>
  gulp.watch \./dev/**/*.ls, <[ livescript ]>

gulp.task \default, <[ livescript watch ]>
