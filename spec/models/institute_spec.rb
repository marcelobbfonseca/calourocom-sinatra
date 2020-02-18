ENV['APP_ENV'] = 'test'

require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

RSpec.describe 'The HelloWorld App' do
  include Rack::Test::Methods

  def app
    @app = Application
  end

  it "Get all institutes" do
    # get '/path', , params={}, 'HTTP_AUTHORIZATION' => "Bearer #{@token}"
    get '/institutes'
    expect(last_response).to be_ok
    # expect(last_response.body).to eq('Hello World')
    # last_response.headers['Content-Length']
  end
end