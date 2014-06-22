class CreateInstagramAccounts < ActiveRecord::Migration
  def change
    create_table :instagram_accounts do |t|
      t.integer :user_id
      t.string :oauth_token
      t.string :uid

      t.timestamps
    end
  end
end
