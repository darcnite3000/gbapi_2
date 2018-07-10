"use strict"

SRC_FOLDER    = "src"
BUILD_FOLDER  = "build"
BOWER_FOLDER  = "bower_components"

module.exports =
  watch: false
  folders:
    src: SRC_FOLDER
    build: BUILD_FOLDER
  paths:
    src:
      index:        "#{SRC_FOLDER}/index.html"
      apps:         ["./#{SRC_FOLDER}/app.coffee"]
      assets:       ["#{SRC_FOLDER}/assets/**/*"
                     "!#{SRC_FOLDER}/assets/images/**/*"
                     "!#{SRC_FOLDER}/assets/fonts/**/*"]
      images:        "#{SRC_FOLDER}/assets/images/**/*"
      fonts:        ["#{SRC_FOLDER}/assets/fonts/**/*"
                     "#{BOWER_FOLDER}/bootstrap-sass-official/assets/fonts/**/*"]
      styles:       "#{SRC_FOLDER}/styles/index.scss"
      vendorStyles: []
      stylesGlob:   "#{SRC_FOLDER}/styles/**/*.scss"
      livereload:   ["#{BUILD_FOLDER}/**/*","!#{BUILD_FOLDER}/assets/**/*"]
    dest:
      styles:   BUILD_FOLDER
      scripts:  BUILD_FOLDER
      images:   "#{BUILD_FOLDER}/assets/images"
      fonts:   "#{BUILD_FOLDER}/assets/fonts"
      assets:   "#{BUILD_FOLDER}/assets"
      index:    BUILD_FOLDER
      server:   BUILD_FOLDER
  filenames:
    min:
      scripts:  'bundle.min.js'
    build:
      scripts:  'bundle.js'
      styles:   'bundle.css'
  ports:
    staticServer:     8080
    livereloadServer: 35729
