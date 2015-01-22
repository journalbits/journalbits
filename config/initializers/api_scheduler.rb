require 'rubygems'
require 'rufus/scheduler'
require 'service_processor'

# include ServiceProcessor

scheduler = Rufus::Scheduler.new


# Runs once a day at 00:01
scheduler.cron("1 0 * * *") do
  # NotifyReauthWorker.perform_async Time.now
end

# Runs every hour at one minute past the hour
scheduler.cron("0 * * * *") do
  puts "This is where the normal processor goes"
  # SuperWorker.perform_async Time.now
  # DailySummaryWorker.perform_async
end

# THIS ONE IS FOR 23:55 EVERY DAY
scheduler.cron("55 23 * * *") do
  # rescue_time_data
end

# Runs twice an hour at 25 and 55 past each hour
scheduler.cron('25,55 * * * *') do
  # LateNightWorker.perform_async Time.now
end

scheduler.schedule_every("10m", { first: "6s" }) do
  SuperWorker.perform_async Time.now
  # processor = ServiceProcessor::GlobalProcessor.new (Time.now)
  # processor.process_all
  # SuperWorker.perform_async Time.now
  # NotifyReauthWorker.perform_async Time.now
end