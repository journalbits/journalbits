class AddDailyEmailPrefToUser < ActiveRecord::Migration
  def change
    add_column :users, :daily_email, :boolean, default: true
  end
end
