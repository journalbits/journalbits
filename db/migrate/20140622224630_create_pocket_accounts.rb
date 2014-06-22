class CreatePocketAccounts < ActiveRecord::Migration
  def change
    create_table :pocket_accounts do |t|
      t.integer :user_id
      t.string :oauth_token

      t.timestamps
    end
  end
end
