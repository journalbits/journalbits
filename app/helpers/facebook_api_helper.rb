require "net/https"

module FacebookApiHelper

  # def facebook_data
  #   User.all.each do |user|
  #     if user.facebook_oauth_token
 
  #     end
  #   end
  # end

  def facebook_test
    user = User.where(email: "hamchapman@gmail.com").first
    token = user.facebook_oauth_token
    @graph = Koala::Facebook::API.new(token)
    puts @graph.get_connections("me", "photos").inspect
  end

  def save_photos date, user
    links = user_added_links_on date, user
    links.each do |link|
      unless FacebookEntry.exists?(item_id: link[1]['item_id'])
        
      end
    end
  end

end
