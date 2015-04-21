# cook_kawasaki

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
```
