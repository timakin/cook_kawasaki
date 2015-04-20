request = require "request"
parser  = require 'xml2json'



GURUNAVI_ACCESS_KEY = "b9afc347ce10cdb3e6846d26ad70bb8e"
GURUNAVI_ORIGIN_URL = "http://api.gnavi.co.jp/ver2/RestSearchAPI/?"
BUILDING_NAME = "ヒカリエ"

module.exports = (robot) ->
  robot.hear /はらへ/, (res) ->
    gurunavi_url = GURUNAVI_ORIGIN_URL + "keyid=" + GURUNAVI_ACCESS_KEY + '&latitude=35.65898718965676&longitude=139.70277630100122&range=3&freeword=' + encodeURIComponent(BUILDING_NAME)
    request gurunavi_url, (_, result) ->
      test = parser.toJson(result.body)
      res.send test.response
      res.send gurunavi_url
