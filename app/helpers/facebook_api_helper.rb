require "net/https"

module FacebookApiHelper

  def facebook_data
    User.all.each do |user|
      if user.facebook_oauth_token
        @graph = Koala::Facebook::API.new(user.facebook_oauth_token)
        save_photos_on (Time.now - 1.day), @graph, user
      end
    end
  end

  def save_photos_on date, client, user
    photos = user_photos_on date, client, user
    photos.each do |photo|
      unless FacebookPhotoEntry.exists?(user_id: user.id, photo_id: photo['id'].to_s)
        FacebookPhotoEntry.create(user_id: user.id, time_created: date.to_s, photo_id: photo['id'].to_s, source_url: photo['source'], link_url: photo['link'], medium_url: photo['images'][photo['images'].count / 2]['source'])
      end
    end
  end

  def user_photos_on date, client, user
    photos = client.get_connections("me", "photos")
    photos.select { |photo| photo['created_time'][0..9] == date.to_s[0..9] }
  end

  # def user_videos_on date, client, user
  #   photos = client.get_connections("me", "videos")
  #   photos_on_date = photos.select { |photo| photo['created_time'][0..9] == date.to_s[0..9] }
  # end

end
