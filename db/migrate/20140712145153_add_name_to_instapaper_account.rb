class AddNameToInstapaperAccount < ActiveRecord::Migration
  def change
    add_column :instapaper_accounts, :name, :string
  end
end
