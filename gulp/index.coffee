"use strict"

gulp        = require 'gulp'
requireDir  = require 'require-dir'

global.config = require './config'

requireDir './tasks'

module.exports = gulp