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
    
    get '/hello/test' do
        'Hello World'
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


    #institute routes
    get '/institutes' do
        institutes = Institute.all
        json institutes
    end

    get '/institutes/:institute_id' do
        institute = Institute.find(params[:institute_id])
        json institute
    end

    post '/institutes' do
        institute_params = MultiJson.load(response.body.read)
        institute = Institute.save(institute_params)
        if institute.save
            json institute
        else
            json institute.errors.messages
        end
    end

    put '/institutes' do
        institute_params = MultiJson.load(response.body.read)
        if institute.update(institute_params)
            response = {status: 200, data:'success, institute updated.'}
            json response
        else
            json institute.errors.messages
        end
    end

    delete '/insitutes/:institute_id' do
        institute = Institute.find(params[:institute_id])
        no_data! unless institute
        institute.destroy
        response = {status: 200, data:'success, institute deleted.'}
        json response
    end
    #posts routes

    get 'institutes/:institute_id/posts' do
        institute = Institute.find(params[:institute_id])
        no_data! unless institute
        json institute.posts
    end

    get 'institutes/:institute_id/posts/:post_id' do
        post = Post.find(params[:post_id])
        no_data! unless post
        json post
    end

    post 'institutes/:institute_id/posts' do
        
        post_params = MultiJson.load(response.body.read)
        post = Post.new(post_params)
        post.institute = Institute.find(params[:institute_id])
        if post.save
            json post
        else 
            json post.errors.messages
        end
    end

    put 'posts/:post_id' do
        post = Post.find(params[:post_id])
        no_data! unless post
        post_params = MultiJson.load response.body.read
        if post.update(post_params)
            response = { message: 'success. Post updated', status: 200}
            json response
        else
            json user.errors.messages
        end
    end
    
    delete '/posts/:post_id' do
        post = Post.find(params[:post_id])
        no_data! unless post
        post.destroy
        response = {status: 200, data:'success, post deleted.'}
        json response
    end

    #comments routes
end
