require "net/https"

module FitbitApiHelper

  def fitbit_data
    client = Fitgem::Client.new( { consumer_key: ENV['FITBIT_CONSUMER_KEY'], consumer_secret: ENV['FITBIT_CONSUMER_SECRET'], oauth_token: "afe0877ee562867851776fe25f9150c9", oauth_secret: "a7ed49ea8d33eb4a59533fafe9b76ae5" } )
    User.all.each do |user|
      if user.fitbit_oauth_token
        client.reconnect("#{user.fitbit_oauth_token}", "#{user.fitbit_oauth_secret}")
        puts user_sleep_on "yesterday", client
        puts user_weight_on "yesterday", client
        puts user_activity_on "yesterday", client
      end
    end
  end

  # def save_commits_to_database commits, date, user
  #   commits.each do |commit|
  #     unless GithubEntry.exists?(:sha => commit.sha)
  #       GithubEntry.create(sha: commit.sha, user_id: user.id, time_created: date, commit_message: commit.commit.message, committer: commit.commit.committer.name, commit_url: commit.commit.url)
  #     end
  #   end
  # end

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

end

# "weight"=>165.1, "weightUnit"=>"METRIC"

 # 0.071429 * lbs = stone


