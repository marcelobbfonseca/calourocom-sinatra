source 'https://rubygems.org'

gem 'sinatra-contrib'       # Required for sinatra/json
gem 'activerecord'          # Ruby ORM
gem 'sinatra-activerecord'  # sinatra activerecord integration
gem 'rake', '~> 12.3'       # ruby makefile
gem 'jwt', '~> 2.1'         # A ruby implementation of the JWT standard
gem 'pundit', '~> 2.1'      # authorization system
gem 'rack-cors', '~> 1.1'   # allow CORS


group :test, :development do
    gem 'sqlite3', '~> 1.3'     # database adapter
    gem 'dotenv'   # load .env file
    gem 'rack-test'   # unit test
    gem "byebug", "~> 10.0" #debugger bundle add byebug --group "development, test"
end

# testing
group :test do
    gem 'database_cleaner-active_record', '~> 1.8'
    gem 'rspec', '~> 3.0'
end

group :production do
    gem 'pg', '~> 1.2.3' #postgres adapter
end