class AddEmailToWunderlistAccount < ActiveRecord::Migration
  def change
    add_column :wunderlist_accounts, :email, :string
  end
end
