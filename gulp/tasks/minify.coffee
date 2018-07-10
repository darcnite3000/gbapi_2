"use strict"

gulp = require 'gulp'
uglify = require 'gulp-uglify'
ngAnnotate = require 'gulp-ng-annotate'
rename = require 'gulp-rename'

module.exports = gulp.task "minify", ['browserify'], ->
  gulp.src "#{config.paths.dest.scripts}/#{config.filenames.build.scripts}"
    .pipe ngAnnotate()
    .pipe uglify()
    .pipe rename config.filenames.min.scripts
    .pipe gulp.dest config.paths.dest.scripts