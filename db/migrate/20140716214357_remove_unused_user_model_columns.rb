class RemoveUnusedUserModelColumns < ActiveRecord::Migration
  def change
    remove_column :users, :twitter_uid
    remove_column :users, :twitter_username
    remove_column :users, :twitter_oauth_token
    remove_column :users, :twitter_oauth_secret
    remove_column :users, :rescue_time_key
    remove_column :users, :github_access_token
    remove_column :users, :wunderlist_token
    remove_column :users, :fitbit_oauth_token
    remove_column :users, :fitbit_oauth_secret
    remove_column :users, :pocket_oauth_token
    remove_column :users, :rdio_oauth_token
    remove_column :users, :rdio_oauth_secret
    remove_column :users, :facebook_oauth_token
    remove_column :users, :facebook_token_expires_at
    remove_column :users, :whatpulse_username
    remove_column :users, :evernote_oauth_token
    remove_column :users, :evernote_token_expires_at
    remove_column :users, :instagram_oauth_token
    remove_column :users, :instagram_uid
    remove_column :users, :instapaper_oauth_token
    remove_column :users, :instapaper_oauth_secret
    remove_column :users, :lastfm_username
    remove_column :users, :moves_oauth_token
    remove_column :users, :moves_refresh_token
    remove_column :users, :health_graph_access_token
  end
end
