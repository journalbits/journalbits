class CreateMovesEntries < ActiveRecord::Migration
  def change
    create_table :moves_entries do |t|
      t.integer :user_id
      t.string :date
      t.string :activity
      t.integer :duration
      t.integer :distance
      t.integer :steps
      t.integer :calories

      t.timestamps
    end
  end
end
