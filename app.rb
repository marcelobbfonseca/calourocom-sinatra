require 'dotenv/load' unless ENV['APP_ENV'].eql? 'production'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require 'pundit'
require './authorization_policy/models_policy'
require './models'
require './lib/middlewares.rb'
require './routes/init'

#set :show_exceptions, false


class Application < Sinatra::Base
    include Pundit
    use JWTAuthorization
    register Sinatra::ActiveRecordExtension

    configure do
        enable :cross_origin
    end
    before do
        response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
        response.headers['Access-Control-Allow-Origin'] = 'https://calourocom.netlify.app/, http://localhost:8080/'
        # response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
        content_type :json
    end

    options '*' do
        response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS,POST'
        response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
        response.headers["Access-Control-Allow-Origin"] = "*"
        200
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


