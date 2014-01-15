class AddCreatedAtToRescueTimeEntries < ActiveRecord::Migration
  def change
    add_column :rescue_time_entries, :created_at, :datetime
  end
end
