request = require "request"
parser  = require 'xml2json'
meshi = require '../lib/meshi'


module.exports = (robot) ->
  robot.hear /はらへ/, (res) ->
    meshi.get_gnavi_page_max()
      .then (page_max) => meshi.get_gnavi_data(page_max)
      .then (promise_array) =>
        Promise.all(promise_array).then (results) =>
          gnavi_rests = []
          for rest_array_item in results
            gnavi_rests = gnavi_rests.concat(rest_array_item)
          res.send gnavi_rests[Math.floor(Math.random()*gnavi_rests.length)]
