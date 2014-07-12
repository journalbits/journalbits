class AddUsernameToHealthGraphAccount < ActiveRecord::Migration
  def change
    add_column :health_graph_accounts, :username, :string
  end
end
