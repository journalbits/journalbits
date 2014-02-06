class RenamePrettyDateToDateForDays < ActiveRecord::Migration
  def change
    rename_column :days, :pretty_date, :date
  end
end
