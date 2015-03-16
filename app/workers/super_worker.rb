class SuperWorker
  include Sidekiq::Worker
  sidekiq_options queue: "super"

  def perform date
    User.all.each do |user|
      process_all date, user.id# if (Time.current + user.time_zone).at_beginning_of_hour.strftime('%H').to_i == 2
    end
  end

  def process_all date, user_id
    EvernoteWorker.perform_async(date, user_id)
    FacebookWorker.perform_async(date, user_id)
    FitbitWorker.perform_async(date, user_id)
    GithubWorker.perform_async(date, user_id)
    HealthGraphWorker.perform_async(date, user_id)
    InstagramWorker.perform_async(date, user_id)
    InstapaperWorker.perform_async(date, user_id)
    LastfmWorker.perform_async(date, user_id)
    MovesWorker.perform_async(date, user_id)
    PocketWorker.perform_async(date, user_id)
    TwitterWorker.perform_async(date, user_id)
    WhatpulseWorker.perform_async(date, user_id)
    WunderlistWorker.perform_async(date, user_id)


    WunderlistWorker.perform_async(date, user_id)

    RescueTimeWorker.perform_async(date, user_id)
  end
end