class CreateWunderlistAccounts < ActiveRecord::Migration
  def change
    create_table :wunderlist_accounts do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
