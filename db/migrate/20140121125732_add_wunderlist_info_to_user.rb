class AddWunderlistInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :wunderlist_email, :string
    add_column :users, :wunderlist_password_digest, :string
  end
end
