require 'sinatra/base'

module Sinatra 
    module UserRoutes
        def self.registered(app)
            app.get '/users' do
                users = User.all
                json users
            end
        
            app.get '/users/:user_id' do
                user = User.find(params[:user_id])
                json user
            end
        
            app.post '/users' do
                request.body.rewind  # in case someone already read it
                
                user_param = MultiJson.load(request.body.read)
                user = User.new( user_param )
                if user.save
                    json user
                else
                    no_data!
                end
            end
            
            app.put '/users/:user_id' do
                user = User.find(params[:user_id])
                no_data! unless user
                authorize user, :edit? #Pundit::NotAuthorizedError
        
                user_params = MultiJson.load request.body.read
                if user.update(user_params)
                    response = { message: 'success. User updated', status: 200}
                    json response
                else
                    json user.errors.messages
                end
            end
        
            app.delete '/users/:user_id' do
                user = User.find(params[:user_id])
                no_data! unless user
                # byebug
                authorize user, :edit?
                user.destroy
                response = {status: 200, data:'success, user deleted.'}
                json response
            end
        
        end
    end
    register UserRoutes # for non modular apps, just include this file and it will register
end