/* eslint arrow-body-style: "off" */

const del = require('del');
const gulp = require('gulp');
// This will put all "gulp-*" modules into $
const $ = require('gulp-load-plugins')({
  DEBUG: process.env.DEBUG,
});

gulp.task('clean', () => {
  del('vendor/assets/javascripts/gulp/*');
  del('vendor/assets/stylesheets/gulp/*');
});

gulp.task('lint:js', () => {
  return gulp.src(['app/gulp/js/**/*.js', '!node_modules/**', '!vendor/**'])
    .pipe($.plumber())
    .pipe($.eslint({ fix: true }))
    .pipe($.eslintIfFixed('app/gulp/js/'))
    .pipe($.eslint.format())
    .pipe($.eslint.failAfterError());
});

gulp.task('build:js', ['lint:js'], () => {
  return gulp.src('app/gulp/js/**/*.js')
    .pipe($.plumber())
    .pipe($.sourcemaps.init())
    .pipe($.babel())
    .pipe($.uglify())
    .pipe($.sourcemaps.write('.'))
    .pipe(gulp.dest('vendor/assets/javascripts/gulp/'));
});

gulp.task('build:sass', () => {
  return gulp.src(['app/gulp/sass/**/*.sass', 'app/gulp/sass/**/*.scss'])
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
