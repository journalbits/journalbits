class AddHealthGraphAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :health_graph_access_token, :string
  end
end
