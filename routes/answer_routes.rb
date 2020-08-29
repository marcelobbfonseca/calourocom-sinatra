require 'sinatra/base'

module Sinatra 
    module AnswerRoutes
        def self.registered(app)
            app.get '/posts/:post_id/answers' do
                post = Post.find(params[:post_id])
                answers = post.answers
                json answers
            end
    
            app.get '/users/:user_id/answers' do
                user = User.find(params[:user_id])
                answers = user.answers
                json answers
            end
    
    
            app.get '/answers/:answer_id' do
                answer = Answer.find(params[:answer_id])
                json answer
            end
    
            app.post '/answers' do
                request.body.rewind  # in case someone already read it
                
                answer_param = MultiJson.load(request.body.read)
                answer = Answer.new( answer_param )
                if answer.save
                    json answer
                else
                    no_data!
                end
            end
    
            app.put '/answers/:answer_id' do
                answer = Answer.find(params[:answer_id])
                no_data! unless answer
                # authorize answer, :edit? #Pundit::NotAuthorizedError
    
                answer_params = MultiJson.load request.body.read
                if answer.update(answer_params)
                    response = { message: 'success. answer updated', status: 200}
                    json response
                else
                    json answer.errors.messages
                end
            end
    
            app.delete '/answers/:answer_id' do
                answer = Answer.find(params[:answer_id])
                no_data! unless answer
                # authorize answer, :edit?
                answer.destroy
                response = {status: 200, data:'success, answer deleted.'}
                json response
            end
        end
    end
    register AnswerRoutes # for non modular apps, just include this file and it will register
end