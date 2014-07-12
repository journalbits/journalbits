class TwitterWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    accounts = TwitterAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      client = create_client_for account
      save_entries_on date, client, user_id, account.id
    end
  end

  def create_client_for account
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = account.oauth_token
      config.access_token_secret = account.oauth_secret
    end
    client
  end

  def save_entries_on date, client, user_id, account_id
    save_tweets_to_database date, client, user_id, account_id
    save_favourites_to_database date, client, user_id, account_id
    save_mentions_to_database date, client, user_id, account_id
  end

  def user_tweets_on date, client
    tweets = client.user_timeline
    tweets.select { |tweet| tweet.created_at.to_s[0..9] == date.to_s[0..9] } if tweets != nil
  end

  def user_favourites_on date, client
    favourites = client.favorites
    favourites.select { |fav| fav.created_at.to_s[0..9] == date.to_s[0..9] } if favourites != nil
  end

  def user_mentions_on date, client
    mentions = client.mentions
    mentions.select { |mention| mention.created_at.to_s[0..9] == date.to_s[0..9] } if mentions != nil
  end

  def save_tweets_to_database date, client, user_id, account_id
    tweets = user_tweets_on date, client
    tweets.each do |tweet|
      unless TwitterEntry.exists?(:tweet_id => tweet.id)
        TwitterEntry.create(
          text: tweet.text,
          kind: "tweet",
          tweeter: tweet.user.username,
          user_id: user_id,
          tweet_id: tweet.id,
          date: date.to_s[0..9],
          tweet_url: tweet.url.to_s,
          twitter_account_id: account_id
        )
      end
    end
  end

  def save_favourites_to_database date, client, user_id, account_id
    favourites = user_favourites_on date, client
    favourites.each do |fav|
      unless TwitterEntry.exists?(:tweet_id => fav.id)
        TwitterEntry.create(
          text: fav.text,
          kind: "favourite",
          tweeter: fav.user.username,
          user_id: user_id,
          tweet_id: fav.id,
          date: date.to_s[0..9],
          tweet_url: fav.url.to_s,
          twitter_account_id: account_id
        )
      end
    end
  end

  def save_mentions_to_database date, client, user_id, account_id
    mentions = user_mentions_on date, client
    mentions.each do |mention|
      unless TwitterEntry.exists?(:tweet_id => mention.id)
        TwitterEntry.create(
          text: mention.text,
          kind: "mention",
          tweeter: mention.user.username,
          user_id: user_id,
          tweet_id: mention.id,
          date: date.to_s[0..9],
          tweet_url: mention.url.to_s,
          twitter_account_id: account_id
        )
      end
    end
  end
end
