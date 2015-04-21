request = require "request"
parser  = require 'xml2json'

GURUNAVI_ACCESS_KEY = "b9afc347ce10cdb3e6846d26ad70bb8e"
GURUNAVI_ORIGIN_URL = "http://api.gnavi.co.jp/ver2/RestSearchAPI/?"
BUILDING_NAME = "ヒカリエ"



module.exports = (robot) ->
  robot.hear /はらへ/, (res) ->
    gurunavi_url = GURUNAVI_ORIGIN_URL + "keyid=" + GURUNAVI_ACCESS_KEY + '&latitude=35.65898718965676&longitude=139.70277630100122&range=4&freeword=' + encodeURIComponent(BUILDING_NAME)
    request gurunavi_url, (_, result) ->
      str_first_body = parser.toJson(result.body)
      obj_first_body = JSON.parse str_first_body
      total_hit_count = JSON.stringify(obj_first_body.response.total_hit_count)
      hit_per_page = JSON.stringify(obj_first_body.response.hit_per_page)
      page_max = Math.floor(total_hit_count / hit_per_page)
      for page_num in [0..page_max]
        url_per_page = gurunavi_url + '&offset_page=' + page_num
        request url_per_page, (_, result) ->
          str_body = parser.toJson(result.body)
          obj_body = JSON.parse str_body
          for restaurant in obj_body.response.rest
            res.send JSON.stringify(restaurant.name.name)
