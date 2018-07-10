"use strict"

gulp            = require 'gulp'
browserify      = require 'browserify'
watchify        = require 'watchify'
# browserifyShim  = require 'browserify-shim'
coffeeify       = require 'coffeeify'
source          = require 'vinyl-source-stream'

module.exports = gulp.task 'browserify', ->
  rebundle = ->
    bundler.bundle()
      .pipe source config.filenames.build.scripts
      .pipe gulp.dest config.paths.dest.scripts

  bConfig =
    entries: config.paths.src.apps
    extensions: ['.coffee']
    cache: {}
    packageCache: {}
    fullPaths: true
    debug: true
  bundler = browserify(bConfig)
    .transform coffeeify
    # .transform browserifyShim
  bundler = watchify(bundler).on('update', rebundle) if config.watch


  rebundle()
