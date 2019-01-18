require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'
require 'rake/testtask'

task :default do
    puts 'type \'rake --tasks\' to list options.'
end

# desc 'Run unit tests'
# task :test do
#     ruby 'app.rb'
#     ruby 'tests/unittest.rb'
# end


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