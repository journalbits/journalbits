require 'rubygems'
require 'rufus/scheduler'
require 'service_processor'

include ServiceProcessor

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

scheduler.schedule_every("2m", { first: "1s" }) do
  processor = ServiceProcessor::GlobalProcessor.new (Time.now - 1.day)
  processor.process_all
end