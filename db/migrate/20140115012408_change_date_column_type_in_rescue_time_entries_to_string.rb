class ChangeDateColumnTypeInRescueTimeEntriesToString < ActiveRecord::Migration
  def change
    change_column :rescue_time_entries, :date, :string
  end
end
