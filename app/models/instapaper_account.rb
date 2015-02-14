# == Schema Information
#
# Table name: instapaper_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  oauth_token  :string
#  oauth_secret :string
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default("true")
#  activated    :boolean          default("true")
#  name         :string
#

class InstapaperAccount < ServiceAccount
  belongs_to :user
  has_many :instapaper_entries
end
