class CreateEvernoteAccounts < ActiveRecord::Migration
  def change
    create_table :evernote_accounts do |t|
      t.integer :user_id
      t.string :oauth_token
      t.datetime :token_expires_at

      t.timestamps
    end
  end
end
