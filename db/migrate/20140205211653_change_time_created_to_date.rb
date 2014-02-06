class ChangeTimeCreatedToDate < ActiveRecord::Migration
  def change
    rename_column :facebook_photo_entries, :time_created, :date
  end
end
