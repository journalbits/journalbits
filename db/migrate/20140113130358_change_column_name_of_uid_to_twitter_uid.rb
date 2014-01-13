class ChangeColumnNameOfUidToTwitterUid < ActiveRecord::Migration
  def change
    rename_column :users, :uid, :twitter_uid
  end
end
