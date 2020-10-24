# Calourocom Sinatra back-end
works with auth Service and Vue client app

## run in comand line
    $ irb
    > require './app'
    # or
    $ bundle exec irb -r app.rb

## Installing gem dependencies
    $ bundle install --without=production #development
    $ bundle install --without development test --deployment #production

## Run localhost application
    $ bundle exec rackup -p 3000
or
    
    $ ruby app.rb
    $ APP_ENV=production ruby app.rb
    $ rerun 'ruby app.rb' # for reloading in dev

## new testing with rspec

    $ bin/rspec

## Database / migrations

    rake db:create RACK_ENV=test
    rake db:migrate RACK_ENV=test
    rake db:migrate RACK_ENV=production
    rake db:migrate:reset # Drop database, create it and re-apply migrations
    rake db:seed



To use the Heroku CLI's autocomplete --
  Via homebrew's shell completion:
    1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
        NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
              and called, either explicitly or via a framework like oh-my-zsh.
    2) Then run
      $ heroku autocomplete --refresh-cache

  OR

  Use our standalone setup:
    1) Run and follow the install steps:
      $ heroku autocomplete