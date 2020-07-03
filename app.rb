require 'dotenv/load' unless ENV['APP_ENV'].eql? 'production'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'pundit'
require "sinatra/cors"
require './authorization_policy/models_policy'
require './models'
require './lib/middlewares.rb'
require './routes/init'

#set :show_exceptions, false


class Application < Sinatra::Base
    include Pundit
    use JWTAuthorization
    register Sinatra::ActiveRecordExtension
    register Sinatra::Cors

    set :allow_origin, "http://localhost:8080 https://calourocom.netlify.app"
    set :allow_methods, "*"
    set :allow_headers, "*"
    set :expose_headers, "*"

    before do
        content_type :json
    end

    def current_user
        env[:user]
    end

    helpers do
        def json( dataset )
            if !dataset #.empty?
                return no_data!
            else
                JSON.pretty_generate(JSON.load(dataset.to_json)) + "\n"
            end
        end
        def no_data!
            response = { message: 'data not found.', status: 204 }.to_json
            json response
        end
    end

    register Sinatra::AnswerRoutes
    register Sinatra::CommentRoutes
    register Sinatra::UserRoutes
    register Sinatra::InstituteRoutes
    register Sinatra::PostRoutes
    register Sinatra::TagRoutes

    error Pundit::NotAuthorizedError do
        message = { error: 'HOLY GUACAMOLY. Unauthorized access.', status: 401}
        halt message
    end

    error do
        halt 'work fuk!'
    end
end

class Protected < Sinatra::Base 
    include Pundit
    use JWTAuthorization
    register Sinatra::ActiveRecordExtension

    before do
        content_type :json
    end
    def current_user
        env[:user]
    end

    get '/hi' do
        puts 'Hello Mister admin!'
        
        response = { message: 'Hello world'}
        json response
    end
end


