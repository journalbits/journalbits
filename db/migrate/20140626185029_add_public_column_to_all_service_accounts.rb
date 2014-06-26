class AddPublicColumnToAllServiceAccounts < ActiveRecord::Migration
  def change
    add_column :evernote_accounts, :public, :boolean, default: true
    add_column :facebook_accounts, :public, :boolean, default: true
    add_column :fitbit_accounts, :public, :boolean, default: true
    add_column :github_accounts, :public, :boolean, default: true
    add_column :health_graph_accounts, :public, :boolean, default: true
    add_column :instagram_accounts, :public, :boolean, default: true
    add_column :instapaper_accounts, :public, :boolean, default: true
    add_column :lastfm_accounts, :public, :boolean, default: true
    add_column :moves_accounts, :public, :boolean, default: true
    add_column :pocket_accounts, :public, :boolean, default: true
    add_column :rescue_time_accounts, :public, :boolean, default: true
    add_column :twitter_accounts, :public, :boolean, default: true
    add_column :whatpulse_accounts, :public, :boolean, default: true
    add_column :wunderlist_accounts, :public, :boolean, default: true
  end
end
