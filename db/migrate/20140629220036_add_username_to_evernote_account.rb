class AddUsernameToEvernoteAccount < ActiveRecord::Migration
  def change
    add_column :evernote_accounts, :username, :string
  end
end
