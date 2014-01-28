class AddInstagramOauthInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :instagram_oauth_token, :string
  end
end
