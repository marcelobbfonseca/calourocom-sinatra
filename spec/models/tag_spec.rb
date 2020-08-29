require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require './models'

RSpec.describe 'Tag routes' do
    include Rack::Test::Methods
  
    def app
      @app = Application
    end

    before(:each) do
        @tag = Tag.create(name:'UnB', color:'blue')
    end

    it "Get all tags" do
        get "/tags"
        expect(last_response).to be_ok
    end
    
    it 'find an existing tag by id' do
        get "/tags/#{@tag.id}"
        found_tag = MultiJson.load last_response.body
        expect(last_response).to be_ok
        expect(found_tag['id']).to be(@tag.id)
    end

    it 'saves a new tag' do
        params = {name: 'CIC', color:'green'}.to_json
        post "/tags", params
        expect(last_response).to be_ok
    end

    it 'updates an existing tag' do
        params = {name: 'CIC', color:'green'}.to_json
        put "/tags/#{@tag.id}", params
        expect(last_response).to be_ok
    end

    it 'delete a post from an institute' do
        delete "/tags/#{@tag.id}"
        expect(last_response).to be_ok
    end
end