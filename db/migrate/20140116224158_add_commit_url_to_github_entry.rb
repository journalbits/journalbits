class AddCommitUrlToGithubEntry < ActiveRecord::Migration
  def change
    add_column :github_entries, :commit_url, :string
  end
end
