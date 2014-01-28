require "net/https"

module InstagramApiHelper

  def instagram_data
    User.all.each do |user|
      if user.instagram_oauth_token
        
      end
    end
  end

  def save_media_on date, user, media
    media.each do |item|
      unless InstagramEntry.exists?()
        InstagramEntry.create(user_id: user.id, time_created: date.to_s)
      end
    end
  end

end
