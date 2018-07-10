"use strict"

angular = require 'angular'

module.exports = angular.module 'app', [
  require('ui-bootstrap').name
  require('angular-resource').name
]
  .constant 'API_URL', 'https://secure.gunzblazingpromo.com/gbpapi/api/v1'
  .controller 'mainCtrl', require './components/mainCtrl'
  .factory 'Site', require './components/services/siteService'
  .factory 'Pack', require './components/services/packService'
  .factory 'Model', require './components/services/modelService'
  .factory 'ngRParams', require './components/ngRParams'
  .filter 'mysqlDate', require './components/filters/mysqlDateFilter'