class CreateLastfmEntries < ActiveRecord::Migration
  def change
    create_table :lastfm_entries do |t|
      t.integer :user_id
      t.string :time_created
      t.string :artist
      t.string :track
      t.string :uts
      t.string :url

      t.timestamps
    end
  end
end
