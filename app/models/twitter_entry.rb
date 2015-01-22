# == Schema Information
#
# Table name: twitter_entries
#
#  id                 :integer          not null, primary key
#  text               :text
#  media              :string(255)
#  kind               :string(255)
#  tweeter            :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  user_id            :integer
#  tweet_id           :integer
#  date               :string(255)
#  tweet_url          :string(255)
#  twitter_account_id :integer
#

class TwitterEntry < ServiceEntry
  belongs_to :user
  belongs_to :twitter_account

  include EntryPusher
end
