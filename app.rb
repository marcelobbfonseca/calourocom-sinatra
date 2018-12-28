require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:forum-service.sqlite3"

# runserver bundle exec rackup -p 3000
class HelloWorld < Sinatra::Base
    get '/' do
        byebug
        'Hello World'
    end

    get '/:name' do
        "Hello #{params[:name]}!"
    end

    #users
    
end