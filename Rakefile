require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'

task :default do
    puts 'type \'rake --tasks\' to list options.'
end

desc 'Run unit tests'
task :test do
    ruby 'test/unittest.rb'
end