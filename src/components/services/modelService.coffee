"use strict"

### @ngInject ###
module.exports = ($resource,$cacheFactory,API_URL)->
  $resource "#{API_URL}/stars/:id",
    modelid: '@id'
  ,
    get:
      method: 'GET'
      cache: $cacheFactory