require "net/https"

module ServiceProcessor
  class InstapaperProcessor
    def initialize date, user
      @user = user
      @date = date
      setup_client
    end

    def process
      save_bookmarks_created_on_date
    end

    def setup_client
      Instapaper.configure do |config|
        config.consumer_key = ENV['INSTAPAPER_CONSUMER_KEY']
        config.consumer_secret = ENV['INSTAPAPER_CONSUMER_SECRET']
        config.oauth_token = "#{@user.instapaper_oauth_token}"
        config.oauth_token_secret = "#{@user.instapaper_oauth_secret}"
      end
    end

    def save_bookmarks_created_on_date
      bookmarks = user_bookmarks_on_date
      bookmarks.each do |bookmark|
        unless InstapaperEntry.exists?(bookmark_id: bookmark.bookmark_id.to_s)
          InstapaperEntry.create(user_id: @user.id, 
                                 date: @date.to_s[0..9], 
                                 bookmark_id: bookmark.bookmark_id.to_s, 
                                 title: bookmark.title, 
                                 url: bookmark.url
                                 )
        end
      end
    end 

    def user_bookmarks_on_date
      bookmarks = Instapaper.bookmarks
      bookmarks.select { |bookmark| Time.at(bookmark.time).to_s[0..9] == @date.to_s[0..9] }
    end

  end
end