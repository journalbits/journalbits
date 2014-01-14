class ChangeTypeOfTweetIdFromIntegerToBigint < ActiveRecord::Migration
  def change
    change_column :twitter_entries, :tweet_id, :bigint
  end
end
