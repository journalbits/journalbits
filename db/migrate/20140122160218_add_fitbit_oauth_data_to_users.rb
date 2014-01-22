class AddFitbitOauthDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fitbit_oauth_token, :string
    add_column :users, :fitbit_oauth_secret, :string
  end
end
