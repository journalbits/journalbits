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
include LastfmApiHelper

scheduler = Rufus::Scheduler.new

# scheduler.cron("0 0 * * *") do

# end 

scheduler.every("15s") do
  # twitter_data
  # rescue_time_data
  # github_data
  # wunderlist_data
  # fitbit_data
  # pocket_data
  # facebook_data
  # whatpulse_data
  # evernote_data
  # instagram_data
  # instapaper_data
  # lastfm_data
end