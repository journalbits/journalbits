require "net/https"

module FitbitApiHelper

  def fitbit_data
    client = Fitgem::Client.new( { consumer_key: ENV['FITBIT_CONSUMER_KEY'], consumer_secret: ENV['FITBIT_CONSUMER_SECRET'], oauth_token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", oauth_secret: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" } )
    User.all.each do |user|
      if user.fitbit_oauth_token
        client.reconnect("#{user.fitbit_oauth_token}", "#{user.fitbit_oauth_secret}")
        save_entries_to_database (Time.now - 1.day), client, user
      end
    end
  end

  def save_entries_to_database date, client, user
    save_sleep_entries date, client, user
    save_activity_entries date, client, user
    save_weight_entries date, client, user
  end

  def user_sleep_on date=nil, client 
    sleep_data = client.sleep_on_date(date)
    if sleep_data != nil
      { minutes_asleep: sleep_data['sleep'].first['minutesAsleep'], minutes_awake: sleep_data['sleep'].first['minutesAwake'], minutes_to_fall_asleep: sleep_data['sleep'].first['minutesToFallAsleep'], efficiency: sleep_data['sleep'].first['efficiency'], times_awake: sleep_data['sleep'].first['awakeningsCount'], sleep_start_time: sleep_data['sleep'].first['startTime'] }
    end
  end

  def user_weight_on date=nil, client
    user_info = client.user_info
    { weight: user_info['weight'], weight_unit: user_info['weightUnit'] }
  end

  def user_activity_on date=nil, client
    activities = client.activities_on_date(date)
    { calories: activities['summary']['caloriesOut'], distance: activities['summary']['distances'].first['distance'], steps: activities['summary']['steps'], active_minutes: activities['summary']['veryActiveMinutes'] }
  end

  def save_sleep_entries date, client, user
    sleep_data = user_sleep_on date, client
    unless FitbitSleepEntry.exists?(date: (Time.now - 1.day).to_s[0..9], user_id: user.id)
      FitbitSleepEntry.create(minutes_asleep: sleep_data[:minutes_asleep], minutes_awake: sleep_data[:minutes_awake], minutes_to_fall_asleep: sleep_data[:minutes_to_fall_asleep], efficiency: sleep_data[:efficiency], times_awake: sleep_data[:times_awake], start_time: sleep_data[:sleep_start_time], date: (Time.now - 1.day).to_s[0..9], user_id: user.id)
    end
  end

  def save_activity_entries date, client, user
    activity_data = user_activity_on date, client
    unless FitbitActivityEntry.exists?(date: (Time.now - 1.day).to_s[0..9], user_id: user.id)
      FitbitActivityEntry.create(calories: activity_data[:calories], distance: activity_data[:distance], steps: activity_data[:steps], active_minutes: activity_data[:active_minutes], date: (Time.now - 1.day).to_s[0..9], user_id: user.id)
    end
  end

  def save_weight_entries date, client, user
    weight_data = user_weight_on date, client
    unless FitbitWeightEntry.exists?(date: (Time.now - 1.day).to_s[0..9], user_id: user.id)
      FitbitWeightEntry.create(weight: weight_data[:weight], weight_unit: weight_data[:weight_unit], date: (Time.now - 1.day).to_s[0..9], user_id: user.id)
    end
  end

  # 0.071429 * lbs = stone

end