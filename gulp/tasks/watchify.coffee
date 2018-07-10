"use strict"

gulp = require 'gulp'

runSequence = require 'run-sequence'
module.exports = gulp.task 'watchify', ->
  runSequence 'setWatch', 'browserify'