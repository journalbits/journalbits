class AddPrivateColumnToGithubEntries < ActiveRecord::Migration
  def change
    add_column :github_entries, :private, :boolean
  end
end
