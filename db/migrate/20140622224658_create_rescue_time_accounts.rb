class CreateRescueTimeAccounts < ActiveRecord::Migration
  def change
    create_table :rescue_time_accounts do |t|
      t.integer :user_id
      t.string :key

      t.timestamps
    end
  end
end
