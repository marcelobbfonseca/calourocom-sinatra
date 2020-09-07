require 'sinatra/base'

module Sinatra 
    module TagRoutes
        def self.registered(app)
            app.get '/tags' do
                if params.empty? then tags = Tag.all else tags = Tag.where(params) end
                json tags
            end
        
            app.get '/tags/:tag_id' do
                tag = Tag.find(params[:tag_id])
                json tag
            end
        
            app.post '/tags' do
                request.body.rewind  # in case someone already read it
                
                tag_param = MultiJson.load(request.body.read)
                tag = Tag.new( tag_param )
                if tag.save
                    json tag
                else
                    no_data!
                end
            end
            
            app.put '/tags/:tag_id' do
                tag = Tag.find(params[:tag_id])
                no_data! unless tag
                authorize tag, :edit? #Pundit::NotAuthorizedError
        
                tag_params = MultiJson.load request.body.read
                if tag.update(tag_params)
                    response = { message: 'success. Tag updated', status: 200}
                    json response
                else
                    json tag.errors.messages
                end
            end
        
            app.delete '/tags/:tag_id' do
                tag = Tag.find(params[:tag_id])
                no_data! unless tag
                authorize tag, :edit?
                tag.destroy
                response = {status: 200, data:'success, tag deleted.'}
                json response
            end
        
        end
    end
    register TagRoutes # for non modular apps, just include this file and it will register
end