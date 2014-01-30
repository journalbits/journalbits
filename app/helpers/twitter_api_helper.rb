require "net/https"

module TwitterApiHelper

  def twitter_data
    setup_client
    User.all.each do |user|
      if user.twitter_oauth_token
        client = personalise_client_for user
        save_entries_to_database (Time.now - 1.day), client, user
      end
    end
  end

  def save_entries_to_database date, client, user
    save_tweets_to_databse date, client, user
    save_favorites_to_databse date, client, user
    save_mentions_to_databse date, client, user
  end

  def user_tweets_on date, client
    tweets = client.user_timeline
    tweets.select { |tweet| tweet.created_at.to_s[0..9] == date.to_s[0..9] } if tweets != nil
  end

  def user_favorites_on date, client
    favorites = client.favorites
    favorites.select { |fav| fav.created_at.to_s[0..9] == date.to_s[0..9] } if favorites != nil
  end

  def user_mentions_on date, client
    mentions = TwitterClient.mentions
    mentions.select { |mention| mention.created_at.to_s[0..9] == date.to_s[0..9] } if mentions != nil
  end

  def save_tweets_to_databse date, client, user
    tweets = user_tweets_on date, client
    tweets.each do |tweet| 
      unless TwitterEntry.exists?(:tweet_id => tweet.id)
        TwitterEntry.create(text: tweet.text, kind: "tweet", tweeter: tweet.user.username, user_id: user.id, tweet_id: tweet.id, time_created: tweet.created_at, tweet_url: tweet.url.to_s)
      end
    end
  end

  def save_favorites_to_databse date, client, user
    favorites = user_favorites_on date, client
    favorites.each do |fav| 
      unless TwitterEntry.exists?(:tweet_id => fav.id)
        TwitterEntry.create(text: fav.text, kind: "favorite", tweeter: fav.user.username, user_id: user.id, tweet_id: fav.id, time_created: fav.created_at, tweet_url: tweet.url.to_s)
      end
    end
  end

  def save_mentions_to_databse date, client, user
    mentions = user_mentions_on date, client
    mentions.each do |mention| 
      unless TwitterEntry.exists?(:tweet_id => mention.id)
        TwitterEntry.create(text: mention.text, kind: "mention", tweeter: mention.user.username, user_id: user.id, tweet_id: mention.id, time_created: mention.created_at, tweet_url: tweet.url.to_s)
      end
    end
  end

  def setup_client
    TwitterClient = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.access_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
    end 
  end

  def personalise_client_for user
    TwitterClient.oauth_token=(user.twitter_oauth_token)
    TwitterClient.oauth_token_secret=(user.twitter_oauth_secret)
    TwitterClient
  end

end