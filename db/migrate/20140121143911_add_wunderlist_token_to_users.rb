class AddWunderlistTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wunderlist_token, :string
  end
end
