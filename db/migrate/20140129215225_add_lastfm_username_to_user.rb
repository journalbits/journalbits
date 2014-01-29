class AddLastfmUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :lastfm_username, :string
  end
end
