class AddUsernameToInstagramAccount < ActiveRecord::Migration
  def change
    add_column :instagram_accounts, :username, :string
  end
end
