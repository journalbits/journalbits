class CreateFitbitAccounts < ActiveRecord::Migration
  def change
    create_table :fitbit_accounts do |t|
      t.integer :user_id
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
  end
end
