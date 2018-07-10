"use strict"

gulp = require 'gulp'

module.exports = gulp.task 'fonts', ->
  gulp.src config.paths.src.fonts
    .pipe gulp.dest config.paths.dest.fonts