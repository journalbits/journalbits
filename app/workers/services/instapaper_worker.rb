class InstapaperWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    # user = User.find(user_id)
    # accounts = user.facebook_accounts.select { |a| a.activated }
    accounts = InstapaperAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      client = create_client_for account
      save_bookmarks_created_on date, client, user_id
    end
  end

  def create_client_for account
    client = Instapaper.configure do |config|
      config.consumer_key = ENV['INSTAPAPER_CONSUMER_KEY']
      config.consumer_secret = ENV['INSTAPAPER_CONSUMER_SECRET']
      config.oauth_token = account.oauth_token
      config.oauth_token_secret = account.oauth_secret
    end
    client
  end

  def save_bookmarks_created_on date, client, user_id
    bookmarks = user_bookmarks_on date, client
    bookmarks.each do |bookmark|
      unless InstapaperEntry.exists?(bookmark_id: bookmark.bookmark_id.to_s)
        InstapaperEntry.create(
          user_id: user_id,
          date: date.to_s[0..9],
          bookmark_id: bookmark.bookmark_id.to_s,
          title: bookmark.title,
          url: bookmark.url
        )
      end
    end
  end

  def user_bookmarks_on date, client
    bookmarks = client.bookmarks
    bookmarks.select { |bookmark| Time.at(bookmark.time).to_s[0..9] == date.to_s[0..9] }
  end
end