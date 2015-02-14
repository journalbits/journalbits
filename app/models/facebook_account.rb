# == Schema Information
#
# Table name: facebook_accounts
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  oauth_token      :string
#  token_expires_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  public           :boolean          default("true")
#  activated        :boolean          default("true")
#  name             :string
#

class FacebookAccount < ServiceAccount
  belongs_to :user
  has_many :facebook_photo_entries

end
