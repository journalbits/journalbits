class AddClefIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :clef_id, :integer, :limit => 8
  end
end
