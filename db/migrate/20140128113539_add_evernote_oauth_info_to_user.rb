class AddEvernoteOauthInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :evernote_oauth_token, :string
    add_column :users, :evernote_token_expires_at, :string
  end
end
