"use strict"

### @ngInject ###
module.exports = ->
  url: (params,asString=false)->
    pairs = if asString then [] else {}
    for own key, item of params
      name = encodeURIComponent key
      if typeof item is 'object'
        for subkey of item
          if !angular.isUndefined item[subkey] && item[subkey]!=""
            pname = "#{name}[#{encodeURIComponent subkey}]"
            if asString
              pairs.push "#{pname}=#{item[subkey]}"
            else
              pairs[pname] = item[subkey]
      else if !angular.isFunction(item) &&
              !angular.isUndefined(item) &&
              item!=""
        if asString
          pairs.push "#{name}=#{encodeURIComponent item}"
        else
          pairs[name] = encodeURIComponent item
    pairs
