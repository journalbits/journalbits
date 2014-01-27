class CreateFacebookPhotoEntries < ActiveRecord::Migration
  def change
    create_table :facebook_photo_entries do |t|
      t.integer :user_id
      t.string :time_created
      t.float :photo_id
      t.string :source_url
      t.string :medium_url
      t.string :link_url

      t.timestamps
    end
  end
end
