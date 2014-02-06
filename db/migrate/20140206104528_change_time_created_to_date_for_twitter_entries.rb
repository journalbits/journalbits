class ChangeTimeCreatedToDateForTwitterEntries < ActiveRecord::Migration
  def change
    rename_column :twitter_entries, :time_created, :date
  end
end
