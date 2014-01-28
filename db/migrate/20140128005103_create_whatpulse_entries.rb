class CreateWhatpulseEntries < ActiveRecord::Migration
  def change
    create_table :whatpulse_entries do |t|
      t.integer :user_id
      t.string :time_created
      t.string :pulse_id
      t.string :keys
      t.string :clicks
      t.integer :download_mb
      t.integer :upload_mb

      t.timestamps
    end
  end
end
