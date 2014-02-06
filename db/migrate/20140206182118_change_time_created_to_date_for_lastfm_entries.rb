class ChangeTimeCreatedToDateForLastfmEntries < ActiveRecord::Migration
  def change
    rename_column :lastfm_entries, :time_created, :date
  end
end
