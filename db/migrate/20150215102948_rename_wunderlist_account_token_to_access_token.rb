class RenameWunderlistAccountTokenToAccessToken < ActiveRecord::Migration
  def change
    rename_column :wunderlist_accounts, :token, :access_token
  end
end
