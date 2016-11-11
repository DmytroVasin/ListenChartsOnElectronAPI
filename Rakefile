require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require './app'
  end

  task :recreate do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end

desc 'This task is called by the Heroku scheduler add-on'
task :update_feed do
  puts "Updating feed..."
  # NewsFeed.update
  puts "done."
end
