require "net/https"

module ServiceProcessor
  class TwitterProcessor
    TwitterClient = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.access_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
    end
    
    def initialize date, user
      @user = user
      @date = date
      @client = setup_client
    end

    def process
      save_entries_on_date
    end

    def setup_client 
      TwitterClient.oauth_token=(@user.twitter_oauth_token)
      TwitterClient.oauth_token_secret=(@user.twitter_oauth_secret)
      TwitterClient
    end

    def save_entries_on_date
      save_tweets_to_database 
      save_favourites_to_database
      save_mentions_to_database
    end

    def user_tweets_on_date
      tweets = @client.user_timeline
      tweets.select { |tweet| tweet.created_at.to_s[0..9] == @date.to_s[0..9] } if tweets != nil
    end

    def user_favourites_on_date
      favourites = @client.favorites
      favourites.select { |fav| fav.created_at.to_s[0..9] == @date.to_s[0..9] } if favourites != nil
    end

    def user_mentions_on_date
      mentions = @client.mentions
      mentions.select { |mention| mention.created_at.to_s[0..9] == @date.to_s[0..9] } if mentions != nil
    end

    def save_tweets_to_database
      tweets = user_tweets_on_date
      tweets.each do |tweet| 
        unless TwitterEntry.exists?(:tweet_id => tweet.id)
          TwitterEntry.create(text: tweet.text, 
                              kind: "tweet", 
                              tweeter: tweet.user.username, 
                              user_id: @user.id, 
                              tweet_id: tweet.id, 
                              date: @date.to_s[0..9], 
                              tweet_url: tweet.url.to_s
                              )
        end
      end
    end

    def save_favourites_to_database
      favourites = user_favourites_on_date
      favourites.each do |fav| 
        unless TwitterEntry.exists?(:tweet_id => fav.id)
          TwitterEntry.create(text: fav.text, 
                              kind: "favourite", 
                              tweeter: fav.user.username, 
                              user_id: @user.id, 
                              tweet_id: fav.id, 
                              date: @date.to_s[0..9], 
                              tweet_url: fav.url.to_s
                              )
        end
      end
    end

    def save_mentions_to_database
      mentions = user_mentions_on_date
      mentions.each do |mention| 
        unless TwitterEntry.exists?(:tweet_id => mention.id)
          TwitterEntry.create(text: mention.text, 
                              kind: "mention", 
                              tweeter: mention.user.username, 
                              user_id: @user.id, 
                              tweet_id: mention.id, 
                              date: @date.to_s[0..9], 
                              tweet_url: mention.url.to_s
                              )
        end
      end
    end
  end
end