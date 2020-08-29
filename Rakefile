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
