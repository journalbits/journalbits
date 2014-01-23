require "net/https"

module TwitterApiHelper

  TwitterClient = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
    config.access_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
  end 

  def twitter_data
    User.all.each do |user|
      TwitterClient.oauth_token=(user.twitter_oauth_token)
      TwitterClient.oauth_token_secret=(user.twitter_oauth_secret)
      favorited(user)
      tweeted(user)
      mentioned(user)
    end
  end

  def favorited(user)
    favorites = TwitterClient.favorites
    if favorites != nil
      favorited_today = favorites.select { |fav| fav.created_at.to_s[0..9] == Time.now.to_s[0..9] }
      favorited_today.each do |fav| 
        unless TwitterEntry.exists?(:tweet_id => fav.id)
          TwitterEntry.create(text: fav.text, kind: "favorite", tweeter: fav.user.username, user_id: user.id, tweet_id: fav.id, time_created: fav.created_at, tweet_url: tweet.url.to_s)
        end
      end
    end
  end

  def tweeted(user)
    tweets = TwitterClient.user_timeline
    if tweets != nil
      tweeted_today = tweets.select { |tweet| tweet.created_at.to_s[0..9] == Time.now.to_s[0..9] }
      tweeted_today.each do |tweet| 
        unless TwitterEntry.exists?(:tweet_id => tweet.id)
          TwitterEntry.create(text: tweet.text, kind: "tweet", tweeter: tweet.user.username, user_id: user.id, tweet_id: tweet.id, time_created: tweet.created_at, tweet_url: tweet.url.to_s)
        end
      end
    end
  end

  def mentioned(user)
    mentions = TwitterClient.mentions
    if mentions != nil
      mentioned_today = mentions.select { |mention| mention.created_at.to_s[0..9] == Time.now.to_s[0..9] }
      mentioned_today.each do |mention| 
        unless TwitterEntry.exists?(:tweet_id => mention.id)
          TwitterEntry.create(text: mention.text, kind: "mention", tweeter: mention.user.username, user_id: user.id, tweet_id: mention.id, time_created: mention.created_at, tweet_url: tweet.url.to_s)
        end
      end
    end
  end

  def tweets_for_user_on_day(max_id, date, user)
    TwitterClient.oauth_token=(user.twitter_oauth_token)
    TwitterClient.oauth_token_secret=(user.twitter_oauth_secret)
    tweets = TwitterClient.user_timeline(max_id: max_id)
    if tweets != nil
      tweeted_on_date = tweets.select { |tweet| tweet.created_at.to_s[0..9] == date.to_s[0..9] }
      tweeted_on_date.each do |tweet| 
        unless TwitterEntry.exists?(:tweet_id => tweet.id)
          TwitterEntry.create(text: tweet.text, kind: "tweet", tweeter: tweet.user.username, user_id: user.id, tweet_id: tweet.id, time_created: tweet.created_at, tweet_url: tweet.url.to_s)
        end
      end
    end
  end

end