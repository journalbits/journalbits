require 'rubygems'
require 'rufus/scheduler'

include TwitterApiHelper

scheduler = Rufus::Scheduler.new

# scheduler.cron("0 0 * * *") do

# end 

scheduler.every("1m") do
  # twitter_data
end 