class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :user_id
      t.string :pretty_date

      t.timestamps
    end
  end
end
