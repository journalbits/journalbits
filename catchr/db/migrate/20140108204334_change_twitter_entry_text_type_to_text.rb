class ChangeTwitterEntryTextTypeToText < ActiveRecord::Migration
  def change
    change_column :twitter_entries, :text, :text
  end
end
