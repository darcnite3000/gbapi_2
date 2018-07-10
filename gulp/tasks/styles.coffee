"use strict"

gulp          = require 'gulp'
sass          = require 'gulp-sass'
autoprefixer  = require 'gulp-autoprefixer'
csscomb       = require 'gulp-csscomb'
rename        = require 'gulp-rename'
es            = require 'event-stream'
concat        = require 'gulp-concat'

module.exports = gulp.task 'styles', ->
  if config.paths.src.vendorStyles.length == 0
    gulp.src config.paths.src.styles
      .pipe sass()
      .pipe rename config.filenames.build.styles
      .pipe autoprefixer 'last 1 version'
      .pipe csscomb()
      .pipe gulp.dest config.paths.dest.styles
  else
    vendorFiles = gulp.src config.paths.src.vendorStyles
    appFiles = gulp.src config.paths.src.styles
      .pipe sass()

    es.concat vendorFiles, appFiles
      .pipe concat config.filenames.build.styles
      .pipe autoprefixer 'last 1 version'
      .pipe csscomb()
      .pipe gulp.dest config.paths.dest.styles
