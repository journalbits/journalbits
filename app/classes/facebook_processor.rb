require "net/https"

module ServiceProcessor
  class FacebookProcessor
    def initialize date, user
      @client = Koala::Facebook::API.new(user.facebook_oauth_token)
      @user = user
      @date = date
    end

    def process 
      save_photos_on_date
    end

    def save_photos_on_date
      photos = user_photos_on_date
      photos.each do |photo|
        unless FacebookPhotoEntry.exists?(user_id: @user.id, photo_id: photo['id'].to_s)
          FacebookPhotoEntry.create(user_id: @user.id, date: @date.to_s[0..9], photo_id: photo['id'].to_s, source_url: photo['source'], link_url: photo['link'], medium_url: photo['images'][photo['images'].count / 2]['source'])
        end
      end
    end

    def user_photos_on_date
      photos = @client.get_connections("me", "photos")
      photos.select { |photo| photo['created_time'][0..9] == @date.to_s[0..9] }
    end
  end
end