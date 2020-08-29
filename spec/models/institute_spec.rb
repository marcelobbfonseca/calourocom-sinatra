require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require './models'

RSpec.describe 'Institute routes' do
  include Rack::Test::Methods

  def app
    @app = Application
  end
    # expect(last_response.body).to eq('Hello World')
    # last_response.headers['Content-Length']
    # get '/path', , params={}, 'HTTP_AUTHORIZATION' => "Bearer #{@token}"
  it "Get all institutes" do
    get '/institutes'
    expect(last_response).to be_ok
  end

  it 'Post a new institute' do
    # add tag
    params = {
                name:"Universidade de Brasilia",
                description: "lorem ipsum",
                category: 1,
              }.to_json
    post '/institutes', params
    expect(last_response).to be_ok
  end

  it 'Find an existing Institute' do
    institute = Institute.create(name: 'Hello', description: 'hi', category: 1)
    get "/institutes/#{institute.id}"
    foundInst = MultiJson.load last_response.body
    expect(last_response).to be_ok
    expect(foundInst['id']).to be(institute.id)
  end

  it 'Updates existing Institute' do
    institute = Institute.create(name: 'Hello', description: 'hi', category: 1)
    params = { description: "Another lorem ipsum", }.to_json
    put "/institutes/#{institute.id}", params
    expect(last_response).to be_ok
  end

  it 'Deletes an Institute' do
    institute = Institute.create(name: 'Hello', description: 'hi', category: 1)
    delete "/institutes/#{institute.id}"
    expect(last_response).to be_ok
  end
end