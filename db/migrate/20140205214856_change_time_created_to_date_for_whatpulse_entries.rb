class ChangeTimeCreatedToDateForWhatpulseEntries < ActiveRecord::Migration
  def change
    rename_column :whatpulse_entries, :time_created, :date
  end
end
