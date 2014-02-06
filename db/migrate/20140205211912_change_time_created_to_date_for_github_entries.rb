class ChangeTimeCreatedToDateForGithubEntries < ActiveRecord::Migration
  def change
    rename_column :github_entries, :time_created, :date
  end
end
