class DailySummaryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "super"

  def perform
    User.all.each do |user|
      if user.daily_email && (Time.current + user.time_zone).at_beginning_of_hour.strftime('%H').to_i == 10
        UserMailer.daily_summary user.id
      end
    end
  end
end