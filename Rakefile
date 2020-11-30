require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'
require 'rake/testtask'

task :default do
    puts 'type \'rake --tasks\' to list options.'
end

namespace :db do
    task :load_config do
      require "./app"
    end
  end


namespace :middleware do
  task :print do 
    require 'rack'
    def middleware_classes(app)
      r = [app]
      while ((next_app = r.last.instance_variable_get(:@app)) != nil)
        r << next_app
      end
      r.map {|e| e.instance_variable_defined?(:@app) ? e.class : e }
    end
    sinatra_app = Rack::Builder.parse_file('config.ru').first
    sinatra_rack_builder = Sinatra::Application.build(sinatra_app)
    sinatra_extended_app = sinatra_rack_builder.to_app
    rack_app = sinatra_extended_app.app
    pp middleware_classes(rack_app)
  end
end