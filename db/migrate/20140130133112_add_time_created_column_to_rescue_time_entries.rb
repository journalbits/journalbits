class AddTimeCreatedColumnToRescueTimeEntries < ActiveRecord::Migration
  def change
    add_column :rescue_time_entries, :time_created, :string
  end
end
