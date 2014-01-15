class AddUserIdToRescueTimeEntries < ActiveRecord::Migration
  def change
    add_column :rescue_time_entries, :user_id, :integer
  end
end
