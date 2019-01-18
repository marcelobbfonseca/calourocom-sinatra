ENV['APP_ENV'] = 'test'

require_relative '../app.rb' 
require 'test/unit'
require 'rack/test'


class HelloWorldTest < Test::Unit::TestCase
    include Rack::Test::Methods
  
    def app
      Application
    end

    before do
    end

    def test_it_says_hello_world
        get '/hello/test'
        assert last_response.ok?
        assert_equal 'Hello World', last_response.body
    end


    def test_create_user
        user_params = {
            name: "Joe",
            wallet: "0x002001932211_JOE",
            email: "e@example.com"
        }
        post '/users', user_params.to_json
        assert last_response.ok?
        #byebug
        user = User.new(user_params)
        response = JSON.parse(last_response.body)
        assert_equal user.name, response['name']
        assert_equal user.wallet, response['wallet']
        assert_equal user.email, response['email']
    end

    def test_get_users
        get '/users'
        assert last_response.ok?
        assert_not_equal nil, last_response.body

    end

    def test_get_user
    end

    def test_update_user
    end
    
    def test_delete_user
    end


    after do
    end
end