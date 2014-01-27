class ChangeFacebookOauthSecretColumnToTokenExpiresAtForUser < ActiveRecord::Migration
  def change
    rename_column :users, :facebook_oauth_secret, :facebook_token_expires_at
  end
end
