
require File.expand_path '../app.rb', __FILE__
require 'rack/cors'

set :environment, :development
#set :database_file, 'config/database.yaml'

# TODO Not loading correctly
# Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }
Dir.glob('./{helpers,}/*.rb').each { |file| require file }

run Rack::URLMap.new({
    "/" => Application,
    "/admin" => Protected
  })

# ActiveRecord::Base.establish_connection(
#   :adapter => 'sqlite3',
#   :database =>  'forum-service.sqlite3.db'
# )
#run Application

#cors rack
use Rack::Cors do
  allow do
    origins '*'     # 'localhost:3000', 'localhost:8080', '0.0.0.0:3000', '127.0.0.1:3000',
    resource '*',  headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head]
  end
end