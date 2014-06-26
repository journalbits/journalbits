class AddActivatedColumnToServiceAccounts < ActiveRecord::Migration
  def change
    add_column :evernote_accounts, :activated, :boolean, default: true
    add_column :facebook_accounts, :activated, :boolean, default: true
    add_column :fitbit_accounts, :activated, :boolean, default: true
    add_column :github_accounts, :activated, :boolean, default: true
    add_column :health_graph_accounts, :activated, :boolean, default: true
    add_column :instagram_accounts, :activated, :boolean, default: true
    add_column :instapaper_accounts, :activated, :boolean, default: true
    add_column :lastfm_accounts, :activated, :boolean, default: true
    add_column :moves_accounts, :activated, :boolean, default: true
    add_column :pocket_accounts, :activated, :boolean, default: true
    add_column :rescue_time_accounts, :activated, :boolean, default: true
    add_column :twitter_accounts, :activated, :boolean, default: true
    add_column :whatpulse_accounts, :activated, :boolean, default: true
    add_column :wunderlist_accounts, :activated, :boolean, default: true
  end
end
