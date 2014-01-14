require "net/https"

module TwitterApiHelper

  TwitterClient = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
    config.access_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
  end 

  def scheduler_test
    # puts "hello"
  end

  def twitter_data
    User.all.each do |user|
      TwitterClient.oauth_token=(user.twitter_oauth_token)
      TwitterClient.oauth_token_secret=(user.twitter_oauth_secret)
      favorited
      tweeted
      mentioned
    end
  end

  def favorited
    favorites = TwitterClient.favorites
    if favorites != nil
      favorited_today = favorites.select { |fav| fav.created_at.to_s[0..9] == Time.now.to_s[0..9] }
      favorited_today.each { |fav| puts fav.text }
    end
  end

  def tweeted
    tweets = TwitterClient.user_timeline
    if tweets != nil
      tweeted_today = tweets.select { |tweet| tweet.created_at.to_s[0..9] == Time.now.to_s[0..9] }
      tweeted_today.each { |tweet| puts tweet.text }
    end
  end

  def mentioned
    mentions = TwitterClient.mentions
    if mentions != nil
      mentioned_today = mentions.select { |mention| mention.created_at.to_s[0..9] == Time.now.to_s[0..9] }
      mentioned_today.each { |mention| puts mention.text }
    end
  end

end