require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:forum-service.sqlite3"

class HelloWorld < Sinatra::Base
    get '/' do
        "Hello World!"
    end

    get '/:name' do
        "Hello #{params[:name]}!"
    end
end