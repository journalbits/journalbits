class RenameTimeZoneToTimeZoneOffsetForUser < ActiveRecord::Migration
  def change
    rename_column :users, :time_zone, :time_zone_offset
  end
end
