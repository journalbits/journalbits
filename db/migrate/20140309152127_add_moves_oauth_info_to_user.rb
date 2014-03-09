class AddMovesOauthInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :moves_oauth_token, :string
    add_column :users, :moves_refresh_token, :string
  end
end
