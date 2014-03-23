class CreateHealthGraphEntries < ActiveRecord::Migration
  def change
    create_table :health_graph_entries do |t|
      t.integer :user_id
      t.string :date
      t.integer :time_asleep
      t.string :kind

      t.timestamps
    end
  end
end
