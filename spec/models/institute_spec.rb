ENV['APP_ENV'] = 'test'

require_relative '../../app'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

RSpec.describe 'The HelloWorld App' do
  include Rack::Test::Methods

  def app
    @app = Application
  end

  before(:all) do
    # @token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvQGhlbGxvLmNvbSIsImlhdCI6MTU4MTMwMTIzMSwiZXhwIjoxNTgxMzA0ODMxLCJpc3MiOiJ1c2VyIn0.IY_Tpse7uP_AHqWCqz3TO8wHfa6FA_esgriiLQrH3u-xni0d7eQx5FWWRzgEAY7NaG5luTVmFueogNqtvP9Ng1gy3bEfiRv_Er5ikuvj8Ej9ZQPIjn_zaZeE2SWn0uYeKg4RToW3_j0dc8F2z_bZ0vf7WJNEFdwO5Ut-XAr6OKFIBu123esL1-JjRsKcwGLO5fm3PZw4uoGnGRYCBZIxoj8ZQeWw06NMqLeooOyBuQwCQWw4BDn_-PtdoANSisuuP9vekw9FyPGs__3U0yLoWpzuTYDJrkRExbTjq8Sz6L7iC6RFPzqZaKGJ68Dpho9gEz4MjmH450Ghw6wB1mcMzw"
  end

  it "Get all institutes" do
    # get '/path', , params={}, 'HTTP_AUTHORIZATION' => "Bearer #{@token}"
    get '/institutes'
    expect(last_response).to be_ok
    # expect(last_response.body).to eq('Hello World')
    # last_response.headers['Content-Length']
  end
end