class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.integer :user_id
      t.string :uid
      t.string :username
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
  end
end
