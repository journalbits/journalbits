class LateNightWorker
  include Sidekiq::Worker
  sidekiq_options queue: "super"

  def perform date
    User.all.each do |user|
      process_rescue_time date, user.id if (Time.current + user.time_zone).at_beginning_of_hour.strftime('%H').to_i == 23
    end
  end

  def process_rescue_time date, user_id
    RescueTimeWorker.perform_async(date, user_id)
  end
end