class AddNameToFacebookAccount < ActiveRecord::Migration
  def change
    add_column :facebook_accounts, :name, :string
  end
end
