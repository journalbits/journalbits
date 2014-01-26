class AddPocketOmniauthInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :pocket_oauth_token, :string
  end
end
