Simple API for [ListenChartsOnElectron](https://github.com/DmytroVasin/ListenChartsOnElectron)

### Heroku routes:
- [Stations](https://winamp-api.herokuapp.com/api/v1/stations)
- [Episode](https://winamp-api.herokuapp.com/api/v1/stations/7/episodes)


### Commands to remember:

##### Start:
```
rackup
heroku addons:open scheduler
heroku logs --tail
```

##### Clear DB on heroku:
```
heroku pg:reset DATABASE
heroku run rake db:migrate
heroku run rake db:seed
```

##### Check that BD is here
```
heroku console
require './app'
Station.all
Episode.all
```

##### Custom rake tasks:
```
rake db:recreate
rake update_feed ( heroku run rake update_feed )
```
