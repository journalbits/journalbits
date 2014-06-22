class CreateWhatpulseAccounts < ActiveRecord::Migration
  def change
    create_table :whatpulse_accounts do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
