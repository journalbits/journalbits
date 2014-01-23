class CreateFitbitWeightEntries < ActiveRecord::Migration
  def change
    create_table :fitbit_weight_entries do |t|
      t.integer :user_id
      t.string :date
      t.float :weight
      t.string :weight_unit

      t.timestamps
    end
  end
end
