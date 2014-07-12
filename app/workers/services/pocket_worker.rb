require "net/https"

class PocketWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    accounts = PocketAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      oauth_token = account.oauth_token
      save_links_on date, oauth_token, user_id, account.id
    end
  end

  def user_added_links_on date, oauth_token
    consumer_key = ENV['POCKET_CONSUMER_KEY']
    unix_date = date.to_time.to_i
    uri = URI("https://getpocket.com/v3/get?access_token=#{oauth_token}&consumer_key=#{consumer_key}&since=#{unix_date}")
    req = Net::HTTP::Get.new uri
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(req)
    end
    JSON.parse(response.body)['list']
  end

  def save_links_on date, oauth_token, user_id, account_id
    links = user_added_links_on date, oauth_token
    links.each do |link|
      unless PocketEntry.exists?(item_id: link[1]['item_id'])
        PocketEntry.create(
          date: date.to_s[0..9],
          user_id: user_id,
          item_id: link[1]['item_id'],
          title: link[1]['resolved_title'],
          url: link[1]['given_url'],
          pocket_account_id: account_id
        )
      end
    end
  end
end
