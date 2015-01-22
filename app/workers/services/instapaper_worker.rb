class InstapaperWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    accounts = InstapaperAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      client = create_client_for account
      save_bookmarks_created_on date, client, user_id, account.id
    end
  end

  def create_client_for account
    client = Instapaper::Client.new({
      consumer_key: ENV['INSTAPAPER_CONSUMER_KEY'],
      consumer_secret: ENV['INSTAPAPER_CONSUMER_SECRET'],
      oauth_token: account.oauth_token,
      oauth_token_secret: account.oauth_secret
    })
    client
  end

  def save_bookmarks_created_on date, client, user_id, account_id
    bookmarks = user_bookmarks_on date, client
    bookmarks.each do |bookmark|
      unless InstapaperEntry.exists?(bookmark_id: bookmark.bookmark_id.to_s)
        InstapaperEntry.create(
          user_id: user_id,
          date: date.to_s[0..9],
          bookmark_id: bookmark.bookmark_id.to_s,
          title: bookmark.title,
          url: bookmark.url,
          instapaper_account_id: account_id
        )
      end
    end
  end

  def user_bookmarks_on date, client
    bookmarks = client.bookmarks
    bookmarks.nil? ? [] : bookmarks.select { |bookmark| Time.at(bookmark.time).to_s[0..9] == date.to_s[0..9] }
  end
end
