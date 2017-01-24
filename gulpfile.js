/* eslint arrow-body-style: "off" */

const gulp = require('gulp');
// This will put all "gulp-*" modules into $
const $ = require('gulp-load-plugins')({
  DEBUG: process.env.DEBUG,
});

gulp.task('lint:js', () => {
  gulp.src(['app/gulp/js/**/*.js', '!node_modules/**', '!vendor/**'])
    .pipe($.eslint())
    .pipe($.eslint.format())
    .pipe($.eslint.failAfterError());
});

gulp.task('build:js', ['lint:js'], () => {
  return gulp.src('app/gulp/js/**/*.js')
    .pipe($.concat('app.js'))
    .pipe(gulp.dest('vendor/assets/javascripts/gulp/'));
});

gulp.task('build:css', () => {
  return gulp.src('app/gulp/css/**/*.css')
    .pipe(gulp.dest('vendor/assets/stylesheets/gulp/'));
});

gulp.task('watch:js', () => {
  gulp.watch('app/gulp/js/**/*.js', ['build:js']);
});

gulp.task('watch:css', () => {
  gulp.watch('app/gulp/css/**/*.css', ['build:css']);
});

gulp.task('watch', ['watch:js', 'watch:css']);
gulp.task('build', ['build:js', 'build:css']);
