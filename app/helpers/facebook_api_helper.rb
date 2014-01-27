require "net/https"

module FacebookApiHelper

  def facebook_data
    User.all.each do |user|
      if user.facebook_oauth_token
        @graph = Koala::Facebook::API.new(user.facebook_oauth_token)
        user_photos_on (Time.now - 1.day), @graph, user
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

  def save_photos date, client, user
    photos = user_photos_on date, client, user
    photos.each do |photo|
      unless FacebookPhotoEntry.exists?(photo_id: photo['id'])
        FacebookPhotoEntry.create()
      end
    end
  end

end
