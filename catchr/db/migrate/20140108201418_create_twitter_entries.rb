class CreateTwitterEntries < ActiveRecord::Migration
  def change
    create_table :twitter_entries do |t|
      t.date :date
      t.string :text
      t.string :media
      t.string :type
      t.string :tweeter

      t.timestamps
    end
  end
end
