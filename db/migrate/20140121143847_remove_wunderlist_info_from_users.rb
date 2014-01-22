class RemoveWunderlistInfoFromUsers < ActiveRecord::Migration

  def up
    remove_column :users, :wunderlist_email, :string
    remove_column :users, :wunderlist_password_digest, :string
  end

  def down
    add_column :users, :wunderlist_email, :string
    add_column :users, :wunderlist_password_digest, :string
  end

end
