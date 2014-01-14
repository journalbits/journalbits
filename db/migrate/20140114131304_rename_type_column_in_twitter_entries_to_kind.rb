class RenameTypeColumnInTwitterEntriesToKind < ActiveRecord::Migration
  def change
    rename_column :twitter_entries, :type, :kind
  end
end
