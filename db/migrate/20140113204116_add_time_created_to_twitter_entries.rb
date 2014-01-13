class AddTimeCreatedToTwitterEntries < ActiveRecord::Migration
  def change
    add_column :twitter_entries, :time_created, :string
  end
end
