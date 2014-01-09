class RenameJournalEntryToDay < ActiveRecord::Migration
  def change
    rename_table :journal_entries, :days
  end
end
