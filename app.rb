require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './models'

set :database, "sqlite3:forum-service.sqlite3"




class HelloWorld < Sinatra::Base
    before do
        content_type :json
    end
    get '/' do
        { hi: 'Hello World'}.to_json
    end

    get '/:name' do
        "Hello #{params[:name]}!"
    end

end

class Application < Sinatra::Base
    before do
        content_type :json
    end
    #users
    get '/users' do
        users = User.all
        users.to_json
    end

    get '/users/:user_id' do
        user = User.find(params[:user_id])
        user
    end
    
    put '/users/:user_id' do
        user = User.find(params[:user_id])
        if user.update(name: params[:name], wallet: params[:wallet], email: params[:email])
            {message: 'success. User updated', status: 200}
        else
            {error: 'something went wrong.'}
    end

    delete '/users/:user_id' do
        user = User.find(params[:user_id])
        user.destroy
        {status: 200, data:'success, user deleted.'}
    end


    after do
        response.body = JSON.dump(response.body)
    end
end