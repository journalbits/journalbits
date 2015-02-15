class AddUidToWunderlistAccount < ActiveRecord::Migration
  def change
    add_column :wunderlist_accounts, :uid, :string
  end
end
