source 'https://rubygems.org'

gem 'sinatra-contrib'       # Required for sinatra/json
gem 'activerecord'          # Ruby ORM
gem 'sinatra-activerecord'  # sinatra activerecord integration
gem 'sqlite3', '~> 1.3'     # database adapter
gem 'rake', '~> 12.3'       # ruby makefile
gem "byebug", "~> 10.0", :groups => [:development, :test] #debugger bundle add byebug --group "development, test"
gem 'rack-test', :groups => [:development, :test]   # unit test
gem 'jwt', '~> 2.1'                                 # A ruby implementation of the JWT standard
gem 'pundit'    # authorization system
gem 'dotenv', groups: [:development, :test]   # load .env file

# testing
group :test do
    gem 'database_cleaner-active_record', '~> 1.8'
    gem 'rspec', '~> 3.0'
end

group :production do
    gem 'pg', '~> 1.2.3' #postgres adapter
end