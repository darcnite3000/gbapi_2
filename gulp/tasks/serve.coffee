"use strict"

gulp          = require 'gulp'
connect       = require 'connect'
serveStatic   = require 'serve-static'
morgan        = require 'morgan'
staticServer  = connect()

module.exports = gulp.task 'serve', (next)->
  staticServer
    .use morgan 'dev'
    .use serveStatic config.folders.build
    .listen process.env.PORT || config.ports.staticServer, next