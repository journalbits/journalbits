class HealthGraphWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'external_api'

  def perform date, user_id
    user = User.find(user_id)
    accounts = user.health_graph_accounts.select { |a| a.activated }
    accounts.each do |account|
      client = create_client_for account
      save_sleep_to_database date, client, user_id
    end
  end

  def create_client_for account
    HealthGraph::User.new account.access_token
  end

  def user_sleep_on date, client
    sleep = client.sleep.items
    sleep.select { |night| Time.parse(night.timestamp).to_s[0..9] == date.to_s[0..9] } if sleep != nil
  end

  def save_sleep_to_database date, client, user_id
    sleep = user_sleep_on(date, client).first
    if !sleep.blank?
      unless HealthGraphEntry.exists?(:user_id => user_id, :date => date.to_s[0..9])
        HealthGraphEntry.create(
          time_asleep: sleep.total_sleep,
          kind: "sleep",
          user_id: user_id,
          date: date.to_s[0..9],
        )
      end
    end
  end
end