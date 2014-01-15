require 'rubygems'
require 'rufus/scheduler'

include TwitterApiHelper
include RescueTimeApiHelper
# include GithubApiHelper

scheduler = Rufus::Scheduler.new

# scheduler.cron("0 0 * * *") do

# end 

scheduler.every("1m") do
  # twitter_data
  # rescue_time_data
  # commits_on_user_repos_today
end 