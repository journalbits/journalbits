class RemoveDateAndCreatedAtColumnsFromRescueTimeEntries < ActiveRecord::Migration
  def change
    remove_column :rescue_time_entries, :date
    remove_column :rescue_time_entries, :created_at
  end
end
