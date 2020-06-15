require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require './models'

RSpec.describe 'User routes' do
  include Rack::Test::Methods

  def app
    @app = Application
  end

  before(:each) do
    @user = User.create(name: 'Oswaldinho',email: 'waldinho@com.com',role: 'user')
  end

  it "Get all users" do
    get "/users"
    expect(last_response).to be_ok
  end

  it 'find an existing user by id' do
    get "/users/#{@user.id}"
    found_user = MultiJson.load last_response.body
    expect(last_response).to be_ok
    expect(found_user['id']).to be(@user.id)
  end

  it 'saves a new user' do
    params = {name: 'CIC', email:'green', role:'user'}.to_json
    post "/users", params
    expect(last_response).to be_ok
  end

  it 'updates an existing user' do
    params = {name: 'valdinho'}.to_json
    put "/users/#{@user.id}", params
    expect(last_response).to be_ok
  end

  it 'deletes an existing user ' do
      delete "/users/#{@user.id}", params={}, rack_env={user: @user}
      expect(last_response).to be_ok
  end
end