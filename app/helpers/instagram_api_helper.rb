require "net/https"

module InstagramApiHelper

  def instagram_data
    User.all.each do |user|
      if user.instagram_oauth_token
        save_media_on Time.now - 1.day, user
      end
    end
  end

  def user_media_on date, user
    media = get_user_media user
    media_today = media.select { |item| Time.at(item['created_time'].to_i).to_s[0..9] == date.to_s[0..9] }
  end

  def get_user_media user
    access_token = user.instagram_oauth_token
    uid = user.instagram_uid
    uri = URI("https://api.instagram.com/v1/users/#{uid}/media/recent/?access_token=#{access_token}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)['data']
  end

  def save_media_on date, user
    media = user_media_on date, user
    media.each do |item|
      unless InstagramEntry.exists?(link_url: item['link'])
        InstagramEntry.create(user_id: user.id, time_created: date.to_s, kind: item['type'], thumbnail_url: item['images']['thumbnail']['url'], standard_url: item['images']['standard_resolution']['url'], caption: item['caption']['text'], link_url: item['link'])
      end
    end
  end

end