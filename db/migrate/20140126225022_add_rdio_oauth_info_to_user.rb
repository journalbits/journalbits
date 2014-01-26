class AddRdioOauthInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :rdio_oauth_token, :string
    add_column :users, :rdio_oauth_secret, :string
  end
end
