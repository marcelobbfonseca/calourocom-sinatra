require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require './models'

RSpec.describe 'Comment routes' do
    include Rack::Test::Methods
  
    def app
      @app = Application
    end
    
    before(:each) do
        @user = User.create(name: 'Dinesh', email: 'dinesh@piper.com', role: 0)
        @institute = Institute.create(name: 'Hello', description: 'hi', category: 1)
        @post = Post.create(title: 'Ciencia da Computação', relevance:0, user_id:@user.id, institute_id:@institute.id)
        @answer = Answer.create(title: '',description: 'Aonde encontro oportunidades de estágio?',relevance: 0,user_id: @user.id,post_id: @post.id)
        
    end

    it "get all comments from a answer" do
        get "/answers/#{@answer.id}/comments"
        expect(last_response).to be_ok
    end

    it "get all comments from an user" do
        get "/users/#{@user.id}/comments"
        expect(last_response).to be_ok
    end


    it 'gets comments by id' do
        comment = Comment.create(description:'Obrigado pela dica!', relevance:0, commentable:@answer, user_id:@user.id )
        get "/comments/#{comment.id}"
        foundComment = MultiJson.load last_response.body
        expect(last_response).to be_ok
        expect(foundComment['id']).to be(comment.id)
    end

    it 'saves a new comment to an answer' do
        params = {
            description:'Obrigado pela dica!', 
            relevance:0, 
            commentable_type:Answer.name,
            commentable_id:@answer.id,
            user_id:@user.id 
        }.to_json
        post "/comments", params
        expect(last_response).to be_ok
    end

    it 'saves a new comment to a post' do
        params = {
            description:'Boa pergunta!', 
            relevance:0, 
            commentable_type:Post.name,
            commentable_id:@post.id,
            user_id:@user.id 
        }.to_json
        post "/comments", params
        expect(last_response).to be_ok
    end
  
    it 'updates an existing comment' do 
      comment = Comment.create(description:'Obrigado pela dica!', relevance:0, commentable:@answer, user_id:@user.id )
      params = {description:'é melhor que scrouble?', relevance: 1}.to_json
      put "/comments/#{comment.id}", params
      expect(last_response).to be_ok
    end

    it 'deletes an existing comment' do
      comment = Comment.create(description:'Obrigado pela dica!', relevance:0, commentable:@answer, user_id:@user.id )
      delete "/comments/#{comment.id}"
      expect(last_response).to be_ok
    end
end