require 'rake'

# Run the tests and build a test package by default
task :default => [:build]

# map test_and_build task to proper tasks
task :test_and_build => [:test, 'gem:clean', 'gem:build']

# map install
task :install => ['gem:install']

task :build => [:test_and_build]

task :test do
  # define the tests
  ruby "test/base.rb"
end

namespace :gem do
  
  task :clean do
    begin
      sh "rm yelp4rails-*"
    rescue
    end
  end
  
  task :build do
    sh "gem build ./yelp4rails.gemspec"
  end
  
  task :install do
    sh "gem install ./yelp4rails"
  end
  
  task :push do
    sh "gem push `ls | grep .gem | grep -v gemspec`"
  end
  
end