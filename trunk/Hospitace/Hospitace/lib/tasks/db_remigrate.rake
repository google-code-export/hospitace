namespace :db do
  task :remigrate => [:drop, :create, :migrate]
end