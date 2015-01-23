# == Schema Information
#
# Table name: instagram_accounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  oauth_token :string(255)
#  uid         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  public      :boolean          default(TRUE)
#  activated   :boolean          default(TRUE)
#  username    :string(255)
#

class InstagramAccount < ServiceAccount
  belongs_to :user
  has_many :instagram_entries
end
