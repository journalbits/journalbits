class AddTweetIdToTwitterEntry < ActiveRecord::Migration
  def change
    add_column :twitter_entries, :tweet_id, :integer
  end
end
