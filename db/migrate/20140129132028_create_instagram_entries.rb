class CreateInstagramEntries < ActiveRecord::Migration
  def change
    create_table :instagram_entries do |t|
      t.integer :user_id
      t.string :time_created
      t.string :kind
      t.string :thumbnail_url
      t.string :standard_url
      t.string :caption
      t.string :link_url

      t.timestamps
    end
  end
end
