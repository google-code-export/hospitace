# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.day, :at => '3:30 am' do
  rake "import"
end

every 1.day, :at => '3:00 pm' do
  command "backup perform --trigger backup"
end


#30 3 * * * /bin/bash -l -c 'cd /home/osman/NetBeansProjects/Hospitace && RAILS_ENV=production bundle exec rake import --silent'
#0 20 * * * /bin/bash -l -c 'backup perform --trigger backup'
