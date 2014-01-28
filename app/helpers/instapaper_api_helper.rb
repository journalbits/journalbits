require "net/https"
require "rss"

module InstapaperApiHelper

  def instapaper_data
    User.all.each do |user|
      if user.instapaper_oauth_token
        
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
