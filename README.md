# run in comand line
    $ irb
    > require './app'


# Run localhost application
    $ bundle exec rackup -p 3001
or
    $ ruby myapp.rb
    $ APP_ENV=production ruby my_app.rb

## new testing with rspec

    $ bin/rspec

## Database / migrations

    rake db:create RACK_ENV=test
    rake db:migrate RACK_ENV=test