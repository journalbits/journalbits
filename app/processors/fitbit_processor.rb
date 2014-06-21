require "net/https"

module ServiceProcessor
  class FitbitProcessor
    def initialize date, user
      @client = client = Fitgem::Client.new( { consumer_key: ENV['FITBIT_CONSUMER_KEY'], 
                                               consumer_secret: ENV['FITBIT_CONSUMER_SECRET'], 
                                               oauth_token: "default", 
                                               oauth_secret: "default" } 
                                               )
      @client.reconnect("#{user.fitbit_oauth_token}", "#{user.fitbit_oauth_secret}")
      @user = user
      @date = date
    end

    def process
      save_entries_to_database
    end

    def save_entries_to_database 
      save_sleep_entries_on_date
      save_activity_entries_on_date
      save_weight_entries_on_date
    end

    def user_sleep_on_date
      sleep_data = @client.sleep_on_date @date
      { minutes_asleep: sleep_data['sleep'].first['minutesAsleep'], 
        minutes_awake: sleep_data['sleep'].first['minutesAwake'],
        minutes_to_fall_asleep: sleep_data['sleep'].first['minutesToFallAsleep'], 
        efficiency: sleep_data['sleep'].first['efficiency'], 
        times_awake: sleep_data['sleep'].first['awakeningsCount'], 
        sleep_start_time: sleep_data['sleep'].first['startTime'] 
      } if !sleep_data['sleep'].empty?
    end

    def user_weight_on_date
      user_info = @client.user_info
      { weight: user_info['weight'], weight_unit: user_info['weightUnit'] }
    end

    def user_activity_on_date
      activities = @client.activities_on_date @date
      { calories: activities['summary']['caloriesOut'], 
        distance: activities['summary']['distances'].first['distance'], 
        steps: activities['summary']['steps'], 
        active_minutes: activities['summary']['veryActiveMinutes'] 
      }
    end

    def save_sleep_entries_on_date
      sleep_data = user_sleep_on_date
      return if !sleep_data
      unless FitbitSleepEntry.exists?(date: @date.to_s[0..9], user_id: @user.id)
        FitbitSleepEntry.create(minutes_asleep: sleep_data[:minutes_asleep], 
                                minutes_awake: sleep_data[:minutes_awake], 
                                minutes_to_fall_asleep: sleep_data[:minutes_to_fall_asleep], 
                                efficiency: sleep_data[:efficiency], 
                                times_awake: sleep_data[:times_awake], 
                                start_time: sleep_data[:sleep_start_time], 
                                date: @date.to_s[0..9], 
                                user_id: @user.id
                                )
      end
    end

    def save_activity_entries_on_date
      activity_data = user_activity_on_date
      unless FitbitActivityEntry.exists?(date: @date.to_s[0..9], user_id: @user.id) || activity_data[:steps] == 0
        FitbitActivityEntry.create(calories: activity_data[:calories], 
                                   distance: activity_data[:distance], 
                                   steps: activity_data[:steps], 
                                   active_minutes: activity_data[:active_minutes], 
                                   date: @date.to_s[0..9], 
                                   user_id: @user.id
                                   )
      end
    end

    def save_weight_entries_on_date
      weight_data = user_weight_on_date
      return if !weight_data[:weight]
      unless FitbitWeightEntry.exists?(date: @date.to_s[0..9], user_id: @user.id)
        FitbitWeightEntry.create(weight: weight_data[:weight], 
                                 weight_unit: weight_data[:weight_unit], 
                                 date: @date.to_s[0..9], 
                                 user_id: @user.id
                                 )
      end
    end
  end
end

# 0.071429 * lbs = stone