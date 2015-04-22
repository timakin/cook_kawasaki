request = require "request"
parser  = require 'xml2json'
gnavi = require '../lib/gnavi'
GURUNAVI_ACCESS_KEY = "b9afc347ce10cdb3e6846d26ad70bb8e"
GURUNAVI_ORIGIN_URL = "http://api.gnavi.co.jp/ver2/RestSearchAPI/?"

get_meshi_response = (res) ->
  keywords = if res.match[1] then res.match[1] else "ヒカリエ"
  GURUNAVI_URL = GURUNAVI_ORIGIN_URL + "keyid=" + GURUNAVI_ACCESS_KEY + '&latitude=35.65898718965676&longitude=139.70277630100122&range=4&freeword=' + encodeURIComponent(keywords);
  gnavi.get_page_max(GURUNAVI_URL)
    .then (page_max) => gnavi.get_restaurants_info(page_max, GURUNAVI_URL)
    .then (promise_array) =>
      Promise.all(promise_array).then (results) =>
        gnavi_rests = []
        for rest_array_item in results
          gnavi_rests = gnavi_rests.concat(rest_array_item)
        gnavi_result = gnavi_rests[Math.floor(Math.random()*gnavi_rests.length)]
        res.send "仕事きついよ〜給料安いよ〜休みないよ〜"
        res.send gnavi_result["name"]
        res.send gnavi_result["url"]

module.exports = (robot) ->
  robot.hear /はらへ/, (res) ->
    get_meshi_response(res)

  robot.hear /めし of (.*)/, (res) ->
    get_meshi_response(res)
