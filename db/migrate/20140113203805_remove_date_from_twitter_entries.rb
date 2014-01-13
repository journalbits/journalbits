class RemoveDateFromTwitterEntries < ActiveRecord::Migration
  
  def up
    remove_column :twitter_entries, :date, :date
  end

  def down
    add_column :twitter_entries, :date, :date
  end
end
