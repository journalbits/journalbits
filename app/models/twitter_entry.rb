# == Schema Information
#
# Table name: twitter_entries
#
#  id                 :integer          not null, primary key
#  text               :text
#  media              :string
#  kind               :string
#  tweeter            :string
#  created_at         :datetime
#  updated_at         :datetime
#  user_id            :integer
#  tweet_id           :integer
#  date               :string
#  tweet_url          :string
#  twitter_account_id :integer
#

class TwitterEntry < ServiceEntry
  belongs_to :user
  belongs_to :twitter_account

  include EntryPusher
end
