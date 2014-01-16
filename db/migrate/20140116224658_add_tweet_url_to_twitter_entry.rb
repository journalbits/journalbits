class AddTweetUrlToTwitterEntry < ActiveRecord::Migration
  def change
    add_column :twitter_entries, :tweet_url, :string
  end
end
