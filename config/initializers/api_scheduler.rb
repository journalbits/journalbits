require 'rubygems'
require 'rufus/scheduler'

# include SchedulerHelper

scheduler = Rufus::Scheduler.new

# scheduler.cron("0 0 * * *") do
   
# end 

scheduler.every("1m") do
  
end 