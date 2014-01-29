require "net/https"

module InstagramApiHelper

  def instagram_data
    User.all.each do |user|
      if user.instagram_oauth_token
        
      end
    end
  end

  def instagram_test
    access_token = User.where(email: "hamchapman@gmail.com").first.instagram_oauth_token
    instagram_uid = "16872267"
    uri = URI("https://api.instagram.com/v1/users/#{instagram_uid}/media/recent/?access_token=#{access_token}")
    response = Net::HTTP.get(uri)
    media = JSON.parse(response)
    puts media.inspect
  end

  def save_media_on date, user
    media = user_media_on date, user
    media.each do |item|
      unless InstagramEntry.exists?()
        InstagramEntry.create(user_id: user.id, time_created: date.to_s)
      end
    end
  end

end
