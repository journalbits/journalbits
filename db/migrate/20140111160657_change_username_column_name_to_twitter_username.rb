class ChangeUsernameColumnNameToTwitterUsername < ActiveRecord::Migration
  def change
    rename_column :users, :username, :twitter_username
  end
end
