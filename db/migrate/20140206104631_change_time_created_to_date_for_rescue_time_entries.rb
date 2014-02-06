class ChangeTimeCreatedToDateForRescueTimeEntries < ActiveRecord::Migration
  def change
    rename_column :rescue_time_entries, :time_created, :date
  end
end
