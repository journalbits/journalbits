# == Schema Information
#
# Table name: instagram_accounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  oauth_token :string
#  uid         :string
#  created_at  :datetime
#  updated_at  :datetime
#  public      :boolean          default("true")
#  activated   :boolean          default("true")
#  username    :string
#

class InstagramAccount < ServiceAccount
  belongs_to :user
  has_many :instagram_entries
end
