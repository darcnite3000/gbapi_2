"use strict"

gulp = require 'gulp'

module.exports = gulp.task 'images', ->
  gulp.src config.paths.src.images
    .pipe gulp.dest config.paths.dest.images