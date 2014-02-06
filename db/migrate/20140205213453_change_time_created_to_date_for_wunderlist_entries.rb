class ChangeTimeCreatedToDateForWunderlistEntries < ActiveRecord::Migration
  def change
    rename_column :wunderlist_entries, :time_created, :date
  end
end
