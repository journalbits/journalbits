class AddUserIdToTwitterEntry < ActiveRecord::Migration
  def change
    add_column :twitter_entries, :user_id, :integer
  end
end
