require "net/https"

module PocketApiHelper

  def pocket_data
    User.all.each do |user|
      if user.pocket_oauth_token
        save_links Date.yesterday.to_time.to_i, user
      end
    end
  end

  def user_added_links_on date, user
    access_token = user.pocket_oauth_token
    consumer_key = ENV['POCKET_CONSUMER_KEY']
    uri = URI("https://getpocket.com/v3/get?access_token=#{access_token}&consumer_key=#{consumer_key}&since=#{date}")
    req = Net::HTTP::Get.new uri
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http| 
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(req) 
    end
    JSON.parse(response.body)['list']
  end

end
