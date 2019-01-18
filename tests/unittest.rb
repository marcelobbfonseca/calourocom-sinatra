ENV['APP_ENV'] = 'test'

require_relative '../app.rb' 
require 'test/unit'
require 'rack/test'

class HelloWorldTest < Test::Unit::TestCase
    include Rack::Test::Methods
  
    def app
      Application
    end

    def test_it_says_hello_world
        get '/hello/test'
        assert last_response.ok?
        assert_equal 'Hello World', last_response.body
    end
end