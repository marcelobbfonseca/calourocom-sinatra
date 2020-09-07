require 'sinatra/base'

module Sinatra 
    module PostRoutes
        def self.registered(app)
            app.get '/posts' do
                posts = Post.all # orderby popular
                json posts
            end
        
            app.get '/institutes/:institute_id/posts' do
                institute = Institute.find(params[:institute_id])
                no_data! unless institute
                json institute.posts
            end
        
            app.get '/posts/:post_id' do
                post = Post.find(params[:post_id])
                no_data! unless post
                json post
            end
        
            app.post '/institutes/:institute_id/posts' do
                post_params = MultiJson.load(request.body.read)
                
                post = Post.new(post_params['post'])
                post.institute = Institute.find(params[:institute_id])
                tags = []
                post_params['tags'].each do |tag_name|
                    tags << Tag.find_or_create_by({name: tag_name, color:'green'})   
                end
                post.tags = tags

                if post.save
                    json post
                else 
                    json post.errors.messages
                end
            end
        
            app.put '/posts/:post_id' do
                post = Post.find(params[:post_id])
                no_data! unless post
                post_params = MultiJson.load request.body.read
                if post.update(post_params)
                    response = { message: 'success. Post updated', status: 200}
                    json response
                else
                    json user.errors.messages
                end
            end
            
            app.delete '/posts/:post_id' do
                post = Post.find(params[:post_id])
                no_data! unless post
                post.destroy
                response = {status: 200, data:'success, post deleted.'}
                json response
            end
        end
    end
    register PostRoutes # for non modular apps, just include this file and it will register
end