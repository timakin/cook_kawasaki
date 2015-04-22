request = require "request"
parser  = require 'xml2json'
meshi = require '../lib/meshi'

GURUNAVI_ACCESS_KEY = "b9afc347ce10cdb3e6846d26ad70bb8e"
GURUNAVI_ORIGIN_URL = "http://api.gnavi.co.jp/ver2/RestSearchAPI/?"
BUILDING_NAME = "ヒカリエ"
gurl = 'http://google.com'
yurl = 'http://yahoo.co.jp'

testreq = (url) ->
  new Promise((resolve, reject) ->
    request url, (error, response, body) ->
      if error
        reject err
      else
        resolve body
      return
    return
  )

class Meshi
  get_page_max: (url) ->
    new Promise((resolve, reject) ->
      request url, (error, response, body) ->
        if error
          console.log "Error!"
          reject err
        else
          str_first_body  = parser.toJson(body)
          obj_first_body  = JSON.parse str_first_body
          total_hit_count = JSON.stringify(obj_first_body.response.total_hit_count)
          hit_per_page    = JSON.stringify(obj_first_body.response.hit_per_page)
          page_max        = Math.floor(total_hit_count / hit_per_page)
          console.log "get_page_max success"
          resolve page_max
        return
      return
    )

  get_gnavi_data: (page_max, url) ->
    console.log "get_gnavi_data start"
    new Promise((resolve, reject) ->
      results = []
      for page_num in [0..page_max-1] by +1
        url_per_page = url + '&offset_page=' + page_num
        console.log page_num
        request url_per_page, (_, result) ->
          console.log url_per_page
          str_body = parser.toJson(result.body)
          obj_body = JSON.parse str_body
          for restaurant in obj_body.response.rest
            results.push(JSON.stringify(restaurant.name.name))
            resolve results
          console.log page_num
          console.log page_max

    )



module.exports = (robot) ->
  robot.hear /はらへ/, (res) ->
    gurunavi_url = GURUNAVI_ORIGIN_URL + "keyid=" + GURUNAVI_ACCESS_KEY + '&latitude=35.65898718965676&longitude=139.70277630100122&range=4&freeword=' + encodeURIComponent(BUILDING_NAME)
    meshi.get_page_max(gurunavi_url)
      .then (page_max) => meshi.get_gnavi_data(page_max, gurunavi_url)
      .then (results) => res.send results

  robot.hear /てすと/, (res) ->
    Promise.all([testreq(gurl),testreq(yurl)]).then (results) ->
      console.log results
      return
