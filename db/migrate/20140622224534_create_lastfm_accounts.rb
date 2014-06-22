class CreateLastfmAccounts < ActiveRecord::Migration
  def change
    create_table :lastfm_accounts do |t|
      t.integer :user_id
      t.string :username

      t.timestamps
    end
  end
end
