class CreateWunderlistEntries < ActiveRecord::Migration
  def change
    create_table :wunderlist_entries do |t|
      t.string :completed_at
      t.string :time_created
      t.string :title
      t.string :list
      t.integer :user_id
      t.string :task_id

      t.timestamps
    end
  end
end
