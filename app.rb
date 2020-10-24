require 'dotenv/load' unless ENV['APP_ENV'].eql? 'production'
require 'sinatra'
require 'sinatra/activerecord'
require 'pundit'
require './authorization_policy/models_policy'
require './models'
require './lib/middlewares.rb'
require './routes/application_routes'
require './helpers/application_helpers' # TODO: move load to config ru
require './helpers/auth_helper'
require 'jwt'
#set :show_exceptions, false unless ENV['APP_ENV'].eql? 'production'


class Application < Sinatra::Base


    helpers ApplicationHelpers
    helpers AuthHelper
    include Pundit
    # use JWTAuthorization
    register Sinatra::ActiveRecordExtension
    set :bind, '0.0.0.0' # make interface available outside localhost


    def current_user
        env[:user]
    end

    before do
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Methods"] = "*"
    end

    options '*' do
        headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
        headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
        halt 200
    end

    get '/teste' do
        protected!
        hello = 'hello world'
        response = { message: 'Ok'}
        json response
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


