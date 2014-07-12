class AddUsernameToPocketAccount < ActiveRecord::Migration
  def change
    add_column :pocket_accounts, :username, :string
  end
end
