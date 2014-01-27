class ChangeDataTypeForFacebookPhotoIdFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :facebook_photo_entries, :photo_id, :string
  end
end
