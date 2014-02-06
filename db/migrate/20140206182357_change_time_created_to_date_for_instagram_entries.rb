class ChangeTimeCreatedToDateForInstagramEntries < ActiveRecord::Migration
  def change
    rename_column :instagram_entries, :time_created, :date
  end
end
