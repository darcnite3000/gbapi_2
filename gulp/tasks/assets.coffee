"use strict"

gulp = require 'gulp'

module.exports = gulp.task 'assets', ->
  gulp.src config.paths.src.assets
    .pipe gulp.dest config.paths.dest.assets