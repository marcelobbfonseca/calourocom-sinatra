require 'byebug'
require './app'


configure :production do
    set :database, "db/production.forum-service.sqlite3"
end

configure :development do
    set :database, "sqlite3:forum-service.sqlite3"
    
end

configure :test do
    set :database, "db/test.forum-service.sqlite3"
end


ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'forum-service.sqlite3.db'
)


run Application