require "net/https"

module InstapaperApiHelper

  def instapaper_data
    setup_client
    User.all.each do |user|
      if user.instapaper_oauth_token
        personalise_client user
        save_bookmarks_created_on (Time.now - 1.day), user
      end
    end
  end

  def setup_client
    Instapaper.configure do |config|
      config.consumer_key = ENV['INSTAPAPER_CONSUMER_KEY']
      config.consumer_secret = ENV['INSTAPAPER_CONSUMER_SECRET']
      config.oauth_token = "DEFAULT"
      config.oauth_token_secret = "DEFAULT"
    end
  end

  def personalise_client user
    Instapaper.oauth_token= user.instapaper_oauth_token
    Instapaper.oauth_token_secret= user.instapaper_oauth_secret
  end

  def save_bookmarks_created_on date, user
    bookmarks = user_bookmarks_on date
    bookmarks.each do |bookmark|
      unless InstapaperEntry.exists?(bookmark_id: bookmark.bookmark_id.to_s)
        InstapaperEntry.create(user_id: user.id, time_created: date.to_s, bookmark_id: bookmark.bookmark_id.to_s, title: bookmark.title, url: bookmark.url)
      end
    end
  end 

  def user_bookmarks_on date
    bookmarks = Instapaper.bookmarks
    bookmarks.select { |bookmark| Time.at(bookmark.time).to_s[0..9] == date.to_s[0..9] }
  end

end
