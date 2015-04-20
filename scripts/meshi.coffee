request = require "request"

module.exports = (robot) ->
  GURUNAVI_ACCESS_KEY = "b9afc347ce10cdb3e6846d26ad70bb8e"
  GURUNAVI_ORIGIN_URL = "http://api.gnavi.co.jp/ver2/RestSearchAPI/?"
  robot.hear /はらへ/, (res) ->
    gurunavi_url = GURUNAVI_ORIGIN_URL + "key_id=" + GURUNAVI_ACCESS_KEY + "&range=3&freeword='ヒカリエ'"
    request gurunavi_url, (_, result) ->
      res.send result
      res.send gurunavi_url
