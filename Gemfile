source 'https://rubygems.org'

# Required for sinatra/json
gem 'sinatra-contrib'
# Ruby ORM
gem 'activerecord'
gem 'sinatra-activerecord'
# database adapter
gem 'sqlite3', '~> 1.3'
# ruby makefile
gem 'rake', '~> 12.3'
#debugger bundle add byebug --group "development, test"
gem "byebug", "~> 10.0", :groups => [:development, :test]
# unit test
gem 'rack-test', :groups => [:development, :test]
# A ruby implementation of the JWT standard
gem 'jwt', '~> 2.1'

# authorization system
gem 'pundit'

# testing
group :test do
    gem 'database_cleaner-active_record', '~> 1.8'
    gem 'rspec', '~> 3.0'
end

group :production do
    gem 'pg', '~> 1.2.3' #postgres adapter
end