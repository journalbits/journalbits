require 'net/https'

class InstagramWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'external_api'

  def perform date, user_id
    # user = User.find(user_id)
    # accounts = user.instagram_accounts.select { |a| a.activated }
    accounts = InstagramAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      save_media_on date, account, user_id
    end
  end

  def user_media_on date, account
    media = get_user_media account
    media.select { |item| Time.at(item['created_time'].to_i).to_s[0..9] == date.to_s[0..9] }
  end

  def get_user_media account
    access_token = account.oauth_token
    uid = account.uid
    uri = URI("https://api.instagram.com/v1/users/#{uid}/media/recent/?access_token=#{access_token}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)['data']
  end

  def save_media_on date, account, user_id
    media = user_media_on date, account
    media.each do |item|
      unless InstagramEntry.exists?(link_url: item['link'])
        InstagramEntry.create(
          user_id: user_id,
          date: date.to_s[0..9],
          kind: item['type'],
          thumbnail_url: item['images']['thumbnail']['url'],
          standard_url: item['images']['standard_resolution']['url'],
          caption: item['caption']['text'],
          link_url: item['link']
        )
      end
    end
  end
end