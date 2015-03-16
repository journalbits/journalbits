require 'net/https'
require 'moves'

class MovesWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    accounts = MovesAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      client = create_client_for account
      save_media_on date, client, user_id, account.id
    end
  end

  def create_client_for account
    Moves::Client.new(account.oauth_token)
  end

  def user_summary_on date, client
    formatted_date = date.to_s[0..9]
    summary = client.daily_summary(formatted_date)[0]
  end

  def save_media_on date, client, user_id, account_id
    summary = user_summary_on date, client
    unless MovesEntry.exists?(user_id: user_id, date: date.to_s[0..9], activity: "total")
      MovesEntry.create(
        user_id: user_id,
        date: date.to_s[0..9],
        activity: "total",
        calories: summary['caloriesIdle'],
        moves_account_id: account_id
      )
    end
    activities = summary['summary']

    if !activities.nil?
      activities.each do |activity|
        unless MovesEntry.exists?(user_id: user_id, date: date.to_s[0..9], activity: activity['activity'])
          MovesEntry.create(
            user_id: user_id,
            date: date.to_s[0..9],
            activity: activity['activity'],
            duration: activity['duration'],
            distance: activity['distance'],
            steps: activity['steps'],
            calories: activity['calories'],
            moves_account_id: account_id
          )
        end
      end
    end
  end
end
