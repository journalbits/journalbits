# == Schema Information
#
# Table name: instapaper_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  oauth_token  :string(255)
#  oauth_secret :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default(TRUE)
#  activated    :boolean          default(TRUE)
#  name         :string(255)
#

class InstapaperAccount < ServiceAccount
  belongs_to :user
  has_many :instapaper_entries
end
