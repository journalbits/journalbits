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

  def facebook_test
    user = User.where(email: "hamchapman@gmail.com").first
    token = user.facebook_oauth_token
    @graph = Koala::Facebook::API.new(token)
    @graph.get_connections("me", "photos")
  end

  def user_photos_on date, client, user
    photos = client.get_connections("me", "photos")
    date = "2013-09-12T15:38:08+0000"
    photos_on_date = photos.select { |photo| photo['created_time'][0..9] == date.to_s[0..9] }
    puts photos_on_date.inspect
  end

  def save_photos date, user
    links = user_added_links_on date, user
    links.each do |link|
      unless FacebookPhotoEntry.exists?(item_id: link[1]['item_id'])
        puts "nuts"
      end
    end
  end

end
