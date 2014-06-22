class CreateHealthGraphAccounts < ActiveRecord::Migration
  def change
    create_table :health_graph_accounts do |t|
      t.integer :user_id
      t.string :access_token

      t.timestamps
    end
  end
end
