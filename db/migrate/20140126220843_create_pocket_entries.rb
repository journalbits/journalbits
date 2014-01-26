class CreatePocketEntries < ActiveRecord::Migration
  def change
    create_table :pocket_entries do |t|
      t.integer :user_id
      t.string :date
      t.string :url
      t.string :title
      t.integer :item_id

      t.timestamps
    end
  end
end
