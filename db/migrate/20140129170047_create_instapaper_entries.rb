class CreateInstapaperEntries < ActiveRecord::Migration
  def change
    create_table :instapaper_entries do |t|
      t.integer :user_id
      t.string :time_created
      t.string :bookmark_id
      t.string :url
      t.string :title

      t.timestamps
    end
  end
end
