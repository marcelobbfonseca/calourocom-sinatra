
require File.expand_path '../app.rb', __FILE__
require 'rack/cors'


ENV['RACK_ENV']? env = ENV['RACK_ENV'].to_sym : env = :development 
set :environment, env

# Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }
Dir.glob('./{helpers}/*.rb').each { |file| require file }

run Rack::URLMap.new({
  "/" => Application,
  "/admin" => Protected
})

#middleware
use Rack::Cors do
  allow do
    origins '*'     # 'localhost:3000', 'localhost:8080', '0.0.0.0:3000', '127.0.0.1:3000',
    resource '*',  headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head],
    max_age: 0,
    expose: :location
  end
end
