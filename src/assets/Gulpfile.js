var gulp = require('gulp');
var sass = require('gulp-sass');
var concat = require('gulp-concat');

var appCssPaths = [
  './scss/**/*.css*',
  './scss/**/*.scss*',
];

function reportChange(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
}

//==================TASKS=====================
gulp.task('css-app', function() {
  return gulp
    .src(appCssPaths)
    // .pipe(concat('app.scss'))
    .pipe(sass())
    .pipe(gulp.dest('../priv/static/css'));
});

gulp.task('default', [
  'css-app'
]);

//==================WATCHERS=====================
gulp.task('watch', function() {
  gulp.watch(appCssPaths, ['css-app']).on('change', reportChange);
});
