
require File.expand_path '../app.rb', __FILE__

set :environment, :development

run Rack::URLMap.new({
    "/" => Application,
    "/admin" => Protected
  })

# ActiveRecord::Base.establish_connection(
#   :adapter => 'sqlite3',
#   :database =>  'forum-service.sqlite3.db'
# )
#run Application