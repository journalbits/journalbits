require "net/https"

module FitbitApiHelper

  def fitbit_data
    client = Fitgem::Client.new( { consumer_key: ENV['FITBIT_CONSUMER_KEY'], consumer_secret: ENV['FITBIT_CONSUMER_SECRET'] } )
    User.all.each do |user|
      client.reconnect("#{user.fitbit_oauth_token}", "#{user.fitbit_oauth_secret}")
      
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
    { minutes_asleep: sleep_data['sleep']['minutesAsleep'], minutes_awake: sleep_data['sleep']['minutesAwake'], minutes_to_fall_asleep: sleep_data['sleep']['minutesToFallAsleep'], efficiency: sleep_data['sleep']['efficiency'], times_awake: sleep_data['sleep']['awakeningsCount'], sleep_start_time: sleep_data['sleep']['startTime'] }
  end

  def user_weight_on date=nil, client
    user_info = client.user_info
    { weight: user_info['weight'], weight_unit: user_info['weightUnit'] }
  end

  def user_activity_on date=nil, client
    activities = client.activities_on_date(date)
    { calories: activities['summary']['caloriesOut'], distance: activities['summary']['distances']['distance'], steps: activities['summary']['steps'], active_minutes: activities['summary']['veryActiveMinutes'] }
  end

end

# "weight"=>165.1, "weightUnit"=>"METRIC"

 # 0.071429 * lbs = stone


