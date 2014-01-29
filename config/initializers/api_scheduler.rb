require 'rubygems'
require 'rufus/scheduler'

include TwitterApiHelper
include RescueTimeApiHelper
include GithubApiHelper
include WunderlistApiHelper
include FitbitApiHelper
include PocketApiHelper
include FacebookApiHelper
include WhatpulseApiHelper
include EvernoteApiHelper
include InstapaperApiHelper
include InstagramApiHelper

scheduler = Rufus::Scheduler.new

# scheduler.cron("0 0 * * *") do

# end 

scheduler.every("10s") do
  # twitter_data
  # rescue_time_data
  # commits_on_user_repos_today
  # wunderlist_data
  # fitbit_data
  # pocket_data
  # facebook_data
  # whatpulse_data
  # evernote_data
  # instapaper_test
  instagram_data
end