require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'
require 'rake/testtask'

task :default do
    puts 'type \'rake --tasks\' to list options.'
end
# rake test                           .run tests normally
# rake test TEST=just_one_file.rb     .run just one test file.
# rake test TESTOPTS="-v"             .run in verbose mode
# rake test TESTOPTS="--runner=fox"   .use the fox test runner
Rake::TestTask.new do |t|
    #t.pattern = "tests/**.rb"
    t.libs << "test"
    t.test_files = FileList['tests/unittest.rb']  # test*.rb for all
    t.verbose = true
end

# namespace :db do
#     desc "Migrate the database"
#     task(:migrate => :environment) do
#       ActiveRecord::Base.logger = Logger.new(STDOUT)
#       ActiveRecord::Migration.verbose = true
#       ActiveRecord::Migrator.migrate("db/migrate")
#     end
# end
