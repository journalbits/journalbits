class EvernoteAccountWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'external_api'

  def perform account_id
    account = EvernoteAccount.find(account_id)
    client = create_client_for account
    save_username_for account, client
  end

  def create_client_for account
    client = EvernoteOAuth::Client.new(
      consumer_key: ENV['EVERNOTE_CONSUMER_KEY'],
      consumer_secret: ENV['EVERNOTE_CONSUMER_SECRET'],
      sandbox:true
    )
    token = account.oauth_token
    client = EvernoteOAuth::Client.new(token: token)
  end

  def save_username_for account, client
    user_store = client.user_store
    username = user_store.getUser.username
    account.update!(username: username)
  end
end