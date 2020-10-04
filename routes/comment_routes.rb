require 'sinatra/base'

module Sinatra 
    module CommentRoutes
        def self.registered(app)
            app.get '/answers/:answer_id/comments' do
                answer = Answer.find(params[:answer_id])
                comments = answer.comments
                json comments
            end
    
            app.get '/users/:user_id/comments' do
                user = User.find(params[:user_id])
                comments = user.comments
                json comments
            end
    
    
            app.get '/comments/:comment_id' do
                comment = Comment.find(params[:comment_id])
                json comment
            end
    
            app.post '/comments' do
                request.body.rewind  # in case someone already read it
                
                comment_params = MultiJson.load(request.body.read)
                comment = Comment.new( comment_params['comment'] )
                if comment.save
                    comment.to_json(include: :author)
                else
                    no_data!
                end
            end
    
            app.put '/comments/:comment_id' do
                comment = Comment.find(params[:comment_id])
                no_data! unless comment
                # authorize comment, :edit? #Pundit::NotAuthorizedError
    
                comment_params = MultiJson.load request.body.read
                if comment.update(comment_params)
                    response = { message: 'success. comment updated', status: 200}
                    json response
                else
                    json comment.errors.messages
                end
            end
    
            app.delete '/comments/:comment_id' do
                comment = Comment.find(params[:comment_id])
                no_data! unless comment
                # authorize comment, :edit?
                comment.destroy
                response = {status: 200, data:'success, comment deleted.'}
                json response
            end
        end
    end
    register CommentRoutes # for non modular apps, just include this file and it will register
end