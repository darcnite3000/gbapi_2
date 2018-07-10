"use strict"

### @ngInject ###
module.exports = ($resource,$cacheFactory,API_URL)->
  $resource "#{API_URL}/packs/:id",
      packid: '@id'
    ,
      get:
        method: 'GET'
        cache: $cacheFactory
