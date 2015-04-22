cook_kawasaki
==============
![2515676_m.jpg](https://qiita-image-store.s3.amazonaws.com/0/16301/f440c84f-2709-0a49-2395-c09bd6c6aced.jpeg "2515676_m.jpg")

Eat happy meshi around Hikarie with your colleagues :D

# How to use

```
// git clone and install node packages
$ git clone git@github.com:timakin/cook_kawasaki.git
$ cd cook_kawasaki
$ npm install

// heroku setting
$ heroku login
$ heroku create [bot_name] // in origin case, named cook_kawasaki
$ heroku addons:add redistogo:nano
$ heroku config:set HUBOT_SLACK_TOKEN=[your token]
$ heroku apps:info // Get you bot Web url for following setting.
$ heroku config:set HUBOT_HEROKU_KEEPALIVE_URL=[your bot app url]
$ git push heroku master

// Random search for restaurant on slack
@cook_kawasaki はらへ
```
