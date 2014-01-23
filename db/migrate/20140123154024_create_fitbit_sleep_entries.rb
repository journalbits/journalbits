class CreateFitbitSleepEntries < ActiveRecord::Migration
  def change
    create_table :fitbit_sleep_entries do |t|
      t.integer :minutes_asleep
      t.integer :minutes_awake
      t.integer :minutes_to_fall_asleep
      t.integer :efficiency
      t.integer :times_awake
      t.string :start_time
      t.integer :user_id
      t.string :date

      t.timestamps
    end
  end
end
