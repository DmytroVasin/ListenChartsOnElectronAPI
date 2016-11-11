# rackup
# heroku addons:open scheduler
# heroku logs --tail

# Clear DB on heroku
# heroku pg:reset DATABASE
# heroku run rake db:migrate
# heroku run rake db:seed

# Check that BD is here
# heroku console
# require './app'
# Station.all
# Episode.all


require './app'

run App
