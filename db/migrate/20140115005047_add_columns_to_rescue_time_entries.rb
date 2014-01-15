class AddColumnsToRescueTimeEntries < ActiveRecord::Migration
  def change
    add_column :rescue_time_entries, :activity_1, :string
    add_column :rescue_time_entries, :time_spent_1, :integer
    add_column :rescue_time_entries, :activity_2, :string
    add_column :rescue_time_entries, :time_spent_2, :integer
    add_column :rescue_time_entries, :activity_3, :string
    add_column :rescue_time_entries, :time_spent_3, :integer
    add_column :rescue_time_entries, :activity_4, :string
    add_column :rescue_time_entries, :time_spent_4, :integer
    add_column :rescue_time_entries, :activity_5, :string
    add_column :rescue_time_entries, :time_spent_5, :integer
    add_column :rescue_time_entries, :date, :time
    add_column :rescue_time_entries, :productivity, :integer
  end
end
