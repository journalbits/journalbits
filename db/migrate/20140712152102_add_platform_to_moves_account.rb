class AddPlatformToMovesAccount < ActiveRecord::Migration
  def change
    add_column :moves_accounts, :platform, :string
  end
end
