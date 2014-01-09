class AddDayIdToTwitterEntries < ActiveRecord::Migration
  def change
    add_column :twitter_entries, :day_id, :integer
  end
end
