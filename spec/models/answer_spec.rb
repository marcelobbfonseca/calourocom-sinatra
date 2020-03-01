require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require './models'

RSpec.describe 'Answer routes' do
    include Rack::Test::Methods
  
    def app
      @app = Application
    end
    
    before(:each) do
        @user = User.create(name: 'Dinesh', email: 'dinesh@piper.com', role: 0)
        @institute = Institute.create(name: 'Hello', description: 'hi', category: 1)
        @post = Post.create(title: 'Ciencia da Computação', relevance:0, user_id:@user.id, institute_id:@institute.id)
    end

    it "get all answers from a post" do
        get "/posts/#{@post.id}/answers"
        expect(last_response).to be_ok
    end

    it "get all answers from an user" do
        get "/users/#{@user.id}/answers"
        expect(last_response).to be_ok
    end


    it 'gets answers by id' do
        answer = Answer.create(title: '',description: 'Aonde encontro oportunidades de estágio?',relevance: 0,user_id: @user.id,post_id: @post.id)
        get "/answers/#{answer.id}"
        foundAnswer = MultiJson.load last_response.body
        expect(last_response).to be_ok
        expect(foundAnswer['id']).to be(answer.id)
    end

    it 'saves a new answer to a post' do
        params = {title: '',description: 'Aonde encontro oportunidades de estágio?',relevance: 0,user_id: @user.id,post_id: @post.id}.to_json
        post "/answers", params
        expect(last_response).to be_ok
    end
  
    it 'updates an existing answer' do 
        answer = Answer.create(description: 'Aonde encontro oportunidades de estágio?',relevance: 0,user_id: @user.id,post_id: @post.id)
        params = {description:'New description', relevance: 1}.to_json
        put "/answers/#{answer.id}", params
        expect(last_response).to be_ok
    end

    it 'deletes an existing answer' do
      answer = Answer.create(description: 'Aonde encontro oportunidades de estágio?',relevance: 0,user_id: @user.id,post_id: @post.id)
      delete "/answers/#{answer.id}"
      expect(last_response).to be_ok
    end
end
