class CreateGithubEntries < ActiveRecord::Migration
  def change
    create_table :github_entries do |t|
      t.integer :user_id
      t.string :sha
      t.string :time_created
      t.string :commit_message
      t.string :committer

      t.timestamps
    end
  end
end
