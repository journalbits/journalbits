class AddInstagramUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :instagram_uid, :string
  end
end
