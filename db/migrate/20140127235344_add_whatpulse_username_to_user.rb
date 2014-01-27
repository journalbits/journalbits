class AddWhatpulseUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :whatpulse_username, :string
  end
end
