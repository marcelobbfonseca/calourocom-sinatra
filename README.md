# Calourocom Sinatra back-end
works with auth Service and Vue client app

## run in comand line
    $ irb
    > require './app'

## Installing gem dependencies
    $ bundle install --without=production
    $ bundle install --without development test --deployment

## Run localhost application
    $ bundle exec rackup -p 3001
or
    $ ruby app.rb
    $ APP_ENV=production ruby app.rb

## new testing with rspec

    $ bin/rspec

## Database / migrations

    rake db:create RACK_ENV=test
    rake db:migrate RACK_ENV=test