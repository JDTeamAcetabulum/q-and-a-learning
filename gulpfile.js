/* eslint arrow-body-style: "off" */

const del = require('del');
const gulp = require('gulp');
// This will put all "gulp-*" modules into $
const $ = require('gulp-load-plugins')({
  DEBUG: process.env.DEBUG,
});

gulp.task('clean:js', () => {
  del('vendor/assets/javascripts/gulp/*');
});

gulp.task('clean:sass', () => {
  del('vendor/assets/stylesheets/gulp/*');
});

gulp.task('clean', ['clean:js', 'clean:sass']);

gulp.task('lint:js', () => {
  return gulp.src(['app/gulp/js/**/*.js'])
    .pipe($.plumber())
    .pipe($.eslint({ fix: true }))
    .pipe($.eslintIfFixed('app/gulp/js/'))
    .pipe($.eslint.format())
    .pipe($.eslint.failAfterError());
});

gulp.task('build:js', ['clean:js', 'lint:js'], () => {
  return gulp.src('app/gulp/js/**/*.js')
    .pipe($.plumber())
    .pipe($.sourcemaps.init())
    .pipe($.babel())
    .pipe($.concat('app.js'))
    .pipe($.uglify())
    .pipe($.sourcemaps.write('.'))
    .pipe(gulp.dest('vendor/assets/javascripts/gulp/'));
});

gulp.task('build:sass', ['clean:sass'], () => {
  return gulp.src(['app/gulp/sass/**/[^_]*.sass', 'app/gulp/sass/**/[^_]*.scss'])
    .pipe($.plumber())
    .pipe($.sourcemaps.init())
    .pipe($.sass().on('error', $.sass.logError))
    .pipe($.autoprefixer())
    .pipe($.sourcemaps.write('.'))
    .pipe(gulp.dest('vendor/assets/stylesheets/gulp/'));
});

gulp.task('watch:js', () => {
  gulp.watch('app/gulp/js/**/*.js', ['build:js']);
});

gulp.task('watch:sass', () => {
  gulp.watch(['app/gulp/sass/**/*.sass', 'app/gulp/sass/**/*.scss'], ['build:sass']);
});

gulp.task('build', ['build:js', 'build:sass']);
gulp.task('watch', ['build', 'watch:js', 'watch:sass']);

gulp.task('default', ['build']);
