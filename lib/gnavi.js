var request = require('request');
var parser  = require('xml2json');

exports.get_page_max = function(url) {
  return new Promise(function(resolve, reject) {
    request(url, function(error, response,body) {
      if (error) {
        reject(err);
      } else {
        var str_first_body  = parser.toJson(body);
        var obj_first_body  = JSON.parse(str_first_body);
        var total_hit_count = JSON.stringify(obj_first_body.response.total_hit_count);
        var hit_per_page    = JSON.stringify(obj_first_body.response.hit_per_page);
        var page_max =  ((total_hit_count < 10) ? 1 : Math.floor(total_hit_count / hit_per_page));
        resolve(page_max);
      }
    });
  });
}

exports.get_restaurants_info = function(page_max, url) {
  return new Promise(function(resolve, reject) {
    var i;
    var promise_array = [];
    for(i = 0; i < page_max; i++) {
      var url_per_page = url + '&offset_page=' + i;
      promise_array[i] = new Promise(function(resolve, reject) {
        request(url_per_page, function(err, result) {
          var rests = [];
          var str_body = parser.toJson(result.body);
          var obj_body = JSON.parse(str_body);
          obj_body.response.rest.map(function(restaurant) {
            rests.push({"name": JSON.stringify(restaurant.name.name), "url": JSON.stringify(restaurant.url)});
          })
          resolve(rests);
        })
      })
    }
    resolve(promise_array);
  });
}
