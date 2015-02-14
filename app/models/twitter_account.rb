# == Schema Information
#
# Table name: twitter_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  uid          :string
#  username     :string
#  oauth_token  :string
#  oauth_secret :string
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default("true")
#  activated    :boolean          default("true")
#

class TwitterAccount < ServiceAccount
  belongs_to :user
  has_many :twitter_entries
end
