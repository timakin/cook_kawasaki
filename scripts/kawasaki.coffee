request = require "request"
parser  = require 'xml2json'
gnavi = require '../lib/gnavi'

module.exports = (robot) ->
  robot.hear /はらへ/, (res) ->
    gnavi.get_page_max()
      .then (page_max) => gnavi.get_restaurants_info(page_max)
      .then (promise_array) =>
        Promise.all(promise_array).then (results) =>
          gnavi_rests = []
          for rest_array_item in results
            gnavi_rests = gnavi_rests.concat(rest_array_item)
          gnavi_result = gnavi_rests[Math.floor(Math.random()*gnavi_rests.length)]
          res.send "仕事きついよ〜給料安いよ〜休みないよ〜"
          res.send gnavi_result["name"]
          res.send gnavi_result["url"]
