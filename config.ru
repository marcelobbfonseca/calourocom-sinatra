
require File.expand_path '../app.rb', __FILE__

set :environment, :development
#set :database_file, 'config/database.yaml'

run Rack::URLMap.new({
    "/" => Application,
    "/admin" => Protected
  })

# ActiveRecord::Base.establish_connection(
#   :adapter => 'sqlite3',
#   :database =>  'forum-service.sqlite3.db'
# )
#run Application