require 'sinatra/base'

module Sinatra 
    module InstituteRoutes
        def self.registered(app)
            app.get '/institutes' do
                institutes = Institute.all
                json institutes
            end
        
            app.get '/institutes/:institute_id' do
                institute = Institute.find(params[:institute_id])
                json institute
            end
        
            app.post '/institutes' do
                institute_params = MultiJson.load(request.body.read)
                institute = Institute.new(institute_params)
                if institute.save
                    json institute
                else
                    json institute.errors.messages
                end
            end
        
            app.put '/institutes/:institute_id' do
                institute = Institute.find(params[:institute_id])
                institute_params = MultiJson.load(request.body.read)
        
                if institute.update(institute_params)
                    response = {status: 200, data:'success, institute updated.'}
                    json response
                else
                    json institute.errors.messages
                end
            end
        
            app.delete '/institutes/:institute_id' do
                institute = Institute.find(params[:institute_id])
                no_data! unless institute
                institute.destroy
                response = {status: 200, data:'success, institute deleted.'}
                json response
            end
        end
    end
    register InstituteRoutes # for non modular apps, just include this file and it will register
end