class AddNameToFitbitAccount < ActiveRecord::Migration
  def change
    add_column :fitbit_accounts, :name, :string
  end
end
