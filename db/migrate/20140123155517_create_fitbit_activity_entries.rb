class CreateFitbitActivityEntries < ActiveRecord::Migration
  def change
    create_table :fitbit_activity_entries do |t|
      t.integer :user_id
      t.string :date
      t.integer :calories
      t.float :distance
      t.integer :steps
      t.integer :active_minutes

      t.timestamps
    end
  end
end
