"use strict"

gulp = require 'gulp'
runSequence = require 'run-sequence'

module.exports = gulp.task 'default', ->
  runSequence 'clean',
    ['index','images','fonts','assets','styles','browserify'],
    'serve'