class AddKindToWunderlistEntries < ActiveRecord::Migration
  def change
    add_column :wunderlist_entries, :kind, :string
  end
end
