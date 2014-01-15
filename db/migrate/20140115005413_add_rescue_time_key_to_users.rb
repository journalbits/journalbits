class AddRescueTimeKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rescue_time_key, :string
  end
end
