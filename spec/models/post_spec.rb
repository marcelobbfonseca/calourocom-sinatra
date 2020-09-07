require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require './models'

RSpec.describe 'Institute routes' do
    include Rack::Test::Methods
  
    def app
      @app = Application
    end
    before(:each) do
        @user = User.create(name: 'Dinesh', email: 'dinesh@piper.com', role: 0)
        @institute = Institute.create(name: 'Hello', description: 'hi', category: 1)
    end

    it "Get all posts from a institute" do
      get "/institutes/#{@institute.id}/posts"
      expect(last_response).to be_ok
    end

    it 'gets all posts' do
      get '/posts'
      expect(last_response).to be_ok
    end

    it 'saves a new post to a institute' do
      params = { post: {title: 'Ciencia da Computação', relevance:0, user_id:@user.id}}.to_json
      post "/institutes/#{@institute.id}/posts", params
      expect(last_response).to be_ok
    end

    it 'updates an existing post' do 
      post = Post.create(title: 'Ciencia da Computação', relevance:0, user_id:@user.id, institute_id:@institute.id)
      params = {title:'New title', relevance: 1}.to_json
      put "/posts/#{post.id}", params
      expect(last_response).to be_ok
    end

    it 'find an existing post by id' do
      post = Post.create(title: 'Ciencia da Computação', relevance:0, user_id:@user.id, institute_id:@institute.id)
      get "/posts/#{@institute.id}"
      found_post = MultiJson.load last_response.body
      expect(last_response).to be_ok
      expect(found_post['id']).to be(post.id)
    end

    it 'delete a post from an institute' do
      post = Post.create(title: 'Ciencia da Computação', relevance:0, user_id:@user.id, institute_id:@institute.id)
      delete "/posts/#{post.id}"
      expect(last_response).to be_ok
    end

end