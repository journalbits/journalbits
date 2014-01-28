class CreateEvernoteEntries < ActiveRecord::Migration
  def change
    create_table :evernote_entries do |t|
      t.integer :user_id
      t.string :time_created
      t.string :note_id
      t.string :kind
      t.string :title

      t.timestamps
    end
  end
end
