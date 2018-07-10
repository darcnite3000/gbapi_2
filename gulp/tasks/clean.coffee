"use strict"

gulp  = require 'gulp'
del   = require 'del'

module.exports = gulp.task "clean", (cb)->
  del [config.folders.build], cb