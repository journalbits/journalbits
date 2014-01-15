require 'rubygems'
require 'rufus/scheduler'

include TwitterApiHelper
include RescueTimeApiHelper

scheduler = Rufus::Scheduler.new

# scheduler.cron("0 0 * * *") do

# end 

scheduler.every("1m") do
  # twitter_data
  # rescue_time_data
end 