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

# THIS ONE IS FOR 00:01 EVERY DAY
scheduler.cron("1 0 * * *") do
  # twitter_data
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

# THIS ONE IS FOR 23:55 EVERY DAY
scheduler.cron("55 23 * * *") do
  # rescue_time_data
end

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