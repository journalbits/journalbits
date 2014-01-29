class AddInstapaperOauthInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :instapaper_oauth_token, :string
    add_column :users, :instapaper_oauth_secret, :string
  end
end
