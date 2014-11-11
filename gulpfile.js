var gulp, gulpLivescript, gulpNotify, gulpUtil;
gulp = require('gulp');
gulpLivescript = require('gulp-livescript');
gulpNotify = require('gulp-notify');
gulpUtil = require('gulp-util');
gulp.task('livescript', function(){
  gulp.src('gulpfile.ls').pipe(gulpLivescript({
    bare: true,
    compile: false
  })).on('error', function(err){
    gulpUtil.log("[error] " + err);
    this.end();
    gulp.src('').pipe(gulpNotify('✖ Browserify Failed ✖'));
  }).pipe(gulp.dest('.'));
  gulp.src('./dev/models/*.ls').pipe(gulpLivescript({
    bare: true,
    compile: false
  })).on('error', function(err){
    gulpUtil.log("[error] " + err);
    this.end();
    gulp.src('').pipe(gulpNotify('✖ Browserify Failed ✖'));
  }).pipe(gulp.dest('./dist/models'));
  gulp.src('./dev/process/*.ls').pipe(gulpLivescript({
    bare: true,
    compile: false
  })).on('error', function(err){
    gulpUtil.log("[error] " + err);
    this.end();
    gulp.src('').pipe(gulpNotify('✖ Browserify Failed ✖'));
  }).pipe(gulp.dest('./dist/process'));
});
gulp.task('watch', function(){
  gulp.watch('gulpfile.ls', ['livescript']);
  gulp.watch('./dev/models/*.ls', ['livescript']);
  return gulp.watch('./dev/process/*.ls', ['livescript']);
});
gulp.task('default', ['livescript', 'watch']);