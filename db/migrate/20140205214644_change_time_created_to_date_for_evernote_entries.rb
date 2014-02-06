class ChangeTimeCreatedToDateForEvernoteEntries < ActiveRecord::Migration
  def change
    rename_column :evernote_entries, :time_created, :date
  end
end
