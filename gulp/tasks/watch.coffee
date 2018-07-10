"use strict"
gulp              = require 'gulp'
livereload        = require 'gulp-livereload'
livereloadServer  = livereload config.ports.livereloadServer

module.exports = gulp.task 'watch', ['watchify'], ->
  gulp.watch config.paths.src.livereload
    .on 'change', (file)->
      livereloadServer.changed(file.path)
  gulp.watch [config.paths.src.index], ['index']
  gulp.watch [config.paths.src.stylesGlob], ['styles']