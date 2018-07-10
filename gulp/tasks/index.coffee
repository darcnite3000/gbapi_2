"use strict"

gulp = require 'gulp'

module.exports = gulp.task 'index', ->
  gulp.src config.paths.src.index
    .pipe gulp.dest config.paths.dest.index