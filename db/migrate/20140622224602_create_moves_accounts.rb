class CreateMovesAccounts < ActiveRecord::Migration
  def change
    create_table :moves_accounts do |t|
      t.integer :user_id
      t.string :oauth_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
