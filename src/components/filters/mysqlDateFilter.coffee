"use strict"

### @ngInject ###
module.exports = ($filter)->
  (input="",format)->
    $filter('date')(new Date(input),format)
