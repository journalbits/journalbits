class AddDateStringToApiEntries < ActiveRecord::Migration
  def change
    add_column :twitter_entries, :pretty_date, :string
    add_column :rescue_time_entries, :pretty_date, :string
    add_column :github_entries, :pretty_date, :string
    add_column :facebook_photo_entries, :pretty_date, :string
    add_column :fitbit_weight_entries, :pretty_date, :string
    add_column :fitbit_activity_entries, :pretty_date, :string
    add_column :fitbit_sleep_entries, :pretty_date, :string
    add_column :whatpulse_entries, :pretty_date, :string
    add_column :instagram_entries, :pretty_date, :string
    add_column :instapaper_entries, :pretty_date, :string
    add_column :pocket_entries, :pretty_date, :string
    add_column :lastfm_entries, :pretty_date, :string
    add_column :evernote_entries, :pretty_date, :string
    add_column :wunderlist_entries, :pretty_date, :string
  end
end
