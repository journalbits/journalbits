require "net/https"
require "rss"

module InstapaperApiHelper

  Instapaper.configure do |config|
    config.consumer_key = ENV['INSTAPAPER_CONSUMER_KEY']
    config.consumer_secret = ENV['INSTAPAPER_CONSUMER_SECRET']
    config.oauth_token = "DEFAULT"
    config.oauth_token_secret = "DEFAULT"
  end

  def instapaper_data
    User.all.each do |user|
      if user.instapaper_oauth_token
        puts "yes"
      end
    end
  end

  def save_notes_created_on date, user, notes    
    links.each do |link|
      unless InstapaperEntry.exists?()
        InstapaperEntry.create(user_id: user.id, time_created: date.to_s)
      end
    end
  end

  def instapaper_test
    rss = RSS::Parser.parse("https://www.instapaper.com/rss/1891509/99mGb31NXT1yupLy4s9EENbIfzI", false)
    rss.items.each do |item|
      puts item.inspect
    end
  end

  def insta_test

  end

end
