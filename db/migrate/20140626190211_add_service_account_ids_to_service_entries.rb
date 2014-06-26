class AddServiceAccountIdsToServiceEntries < ActiveRecord::Migration
  def change
    add_column :evernote_entries, :evernote_account_id, :integer
    add_column :facebook_photo_entries, :facebook_account_id, :integer
    add_column :fitbit_activity_entries, :fitbit_account_id, :integer
    add_column :fitbit_sleep_entries, :fitbit_account_id, :integer
    add_column :fitbit_weight_entries, :fitbit_account_id, :integer
    add_column :github_entries, :github_account_id, :integer
    add_column :health_graph_entries, :health_graph_account_id, :integer
    add_column :instagram_entries, :instagram_account_id, :integer
    add_column :instapaper_entries, :instapaper_account_id, :integer
    add_column :lastfm_entries, :lastfm_account_id, :integer
    add_column :moves_entries, :moves_account_id, :integer
    add_column :pocket_entries, :pocket_account_id, :integer
    add_column :rescue_time_entries, :rescue_time_account_id, :integer
    add_column :twitter_entries, :twitter_account_id, :integer
    add_column :whatpulse_entries, :whatpulse_account_id, :integer
    add_column :wunderlist_entries, :wunderlist_account_id, :integer
  end
end
