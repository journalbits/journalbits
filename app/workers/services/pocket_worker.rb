require 'pocket'

class PocketWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    accounts = PocketAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      client = create_client_for account
      save_bookmarks_created_on date, client, user_id, account.id
    end
  end

  def create_client_for account
    client = Pocket::Client.new(
      consumer_key: ENV['POCKET_CONSUMER_KEY'],
      access_token: account.oauth_token
    )
    client
  end

  def save_bookmarks_created_on date, client, user_id, account_id
    bookmarks = user_bookmarks_on date, client
    bookmarks.each do |bookmark|
      unless PocketEntry.exists?(item_id: bookmark[1]['item_id'])
        PocketEntry.create(
          date: date.to_s[0..9],
          user_id: user_id,
          item_id: bookmark[1]['item_id'],
          title: bookmark[1]['resolved_title'],
          url: bookmark[1]['given_url'],
          pocket_account_id: account_id
        )
      end
    end
  end

  def user_bookmarks_on date, client
    response = client.retrieve(since: date.to_time.to_i)
    response['list'].blank? ? [] : response['list']
  end
end