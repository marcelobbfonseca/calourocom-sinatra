require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
#require 'json'
require './models'

set :database, "sqlite3:forum-service.sqlite3"



class Application < Sinatra::Base
    before do
        content_type :json
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

    #users
    get '/users' do
        users = User.all
        json users
    end

    get '/users/:user_id' do
        user = User.find(params[:user_id])
        json user
    end

    post '/users' do
        request.body.rewind  # in case someone already read it
        # user = JSON.parse request.body.read
        # if User.create(name: user.name, wallet:user.wallet, email: user.email)
        #     {message: 'success. User updated', status: 200}
        # else 
        #     {error: 'something went wrong.', status: 404}
        # end
        
        user_param = MultiJson.load(request.body.read)
        user = User.new( user_param )
        if user.save
            json user
        else
            no_data!
        end
    end
    
    put '/users/:user_id' do
        user = User.find(params[:user_id])
        no_data! unless user
        user_params = MultiJson.load request.body.read
        if user.update(user_params)
            response = { message: 'success. User updated', status: 200}
            json response
        else
            json user.errors.messages
        end
    end

    delete '/users/:user_id' do
        user = User.find(params[:user_id])
        no_data! unless user

        user.destroy
        response = {status: 200, data:'success, user deleted.'}
        json response
    end


    # after do
    #     response.body = JSON.dump(response.body)
    # end
end