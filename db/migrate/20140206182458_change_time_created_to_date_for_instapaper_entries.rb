class ChangeTimeCreatedToDateForInstapaperEntries < ActiveRecord::Migration
  def change
    rename_column :instapaper_entries, :time_created, :date
  end
end
